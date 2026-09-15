---
title: Crab Collab
theme: white
revealOptions:
  width: 1280
  height: 720
  slideNumber: true
  pdfSeparateFragments: false
---

<style>
.reveal h1, .reveal h2, .reveal h3 { text-transform: none; }
.reveal { font-size: 34px; }
.reveal table { font-size: 0.85em; }
.reveal img { max-height: 560px; border: none; box-shadow: none; }
.reveal video { max-height: 620px; }
html.print-pdf video::-webkit-media-controls { display: none !important; }
.muted { color: #888; font-size: 0.7em; }
.fi { display: flex; justify-content: center; gap: 0.5em; font-family: monospace; }
.fi span { border: 2px solid #999; padding: 0.3em 0.8em; }
.fi .new { border-color: #2a76dd; color: #2a76dd; }
.fi .dead { color: #bbb; text-decoration: line-through; border-style: dashed; }
.fi .conc { border-color: #d9a400; }
.fi .good { border-color: #2a2; color: #060; background: #e2f5e2; }
.fi .bad { border-color: #d33; color: #900; background: #fde2e2; }
.fi .arr { border: none; padding: 0.3em 0; }
.row { display: flex; align-items: center; gap: 0.8em; margin: 0.5em 0; font-size: 0.85em; }
.row .lbl { width: 7em; text-align: right; color: #888; font-size: 0.8em; }
.sync { display: flex; align-items: center; justify-content: center; gap: 0.8em; margin: 1em 0; }
.sync .box { border: 2px solid #ccc; border-radius: 10px; padding: 0.5em 0.8em; }
.sync .fi { margin: 0.5em 0; }
.sync .mid { font-size: 0.7em; }
.sync .op { border: 2px solid; padding: 0.2em 0.6em; margin: 0.3em 0; font-family: monospace; }
.sync .wait { background: #fff4d6; border-color: #d9a400; }
.sync .sent { background: #dde9fb; border-color: #2a76dd; }
.logos { display: flex; justify-content: space-between; align-items: center; }
.logos img { height: 110px; margin: 0; }
</style>

<div class="logos"><img src="media/uns-logo.svg" alt="УНС"><img src="media/ftn-logo.svg" alt="ФТН"></div>

## Колаборативна _Jupyter_ биљежница са подршком за уређивање и извршавање у реалном времену

Никола Јоловић, SV9/2022

<p class="muted">Ментор: проф. др Игор Дејановић<br>Нови Сад, 2026.</p>

---

## Проблем

----

### Мотивација

- Рачунарска биљежница (енг. _computational notebook_):
    - текст + код + резултати извршавања
    - _Jupyter_ стандард
- Сарадња у реалном времену:
    - текст: _Google Docs_
    - графика: _Figma_

----

### Циљ и опсег

- _Crab Collab_: колаборативна _Jupyter_ биљежница у реалном времену
- Циљ:
  - рјешавање конфликата при истовременим измјенама
  - интеграција извршавања кода
- Доказ концепта

----

### Демо

<video src="media/demo.mp4" controls></video>

---

## Систем

----

### Архитектура

<img src="media/sistem.png" alt="Архитектура система" style="height: 450px">

<div class="fi" style="font-size: 0.7em; font-family: inherit"><span>локална примјена</span><span class="arr">→</span><span>сервер рјешава конфликт</span><span class="arr">→</span><span>шаље свима (аутору као потврду)</span></div>

----

### Технологије

- **Комуникација:**
    - _WebSocket_: клијент–сервер
    - _ZeroMQ_: сервер–кернел
- **Језгро за рјешавање конфликата:** Раст → _WebAssembly_
  - иста имплементација на клијенту и серверу

---

## Рјешавање конфликата

----

### Операциона трансформација

<img src="media/ot.png" alt="ОТ примјер" style="height: 430px">

Измјена се **прилагођава** ономе што се десило прије ње

----

### _Conflict-free Replicated Data Type_ (_CRDT_)

<img src="media/crdt.png" alt="CRDT примјер" style="width: 880px">

Структура **сама** конвергира, редослијед није битан

<div class="fragment" style="display: inline-block; text-align: left">
<div class="row"><span class="lbl">корисник види</span><div class="fi"><span>а</span><span>б</span><span>г</span></div></div>
<div class="row"><span class="lbl"><em>CRDT</em> чува</span><div class="fi"><span>а<sub>А1</sub></span><span>б<sub>А2</sub></span><span class="dead">в<sub>Б1</sub></span><span>г<sub>Б2</sub></span></div></div>
<p class="muted">Цијена: ИД за сваки карактер (реплика + бројач), обрисани остају</p>
</div>

----

### Централни сервер

<img src="media/server.png" alt="Сервер одређује редослијед" style="height: 380px">

Један редослијед измјена → **оба приступа постају једноставнија**

----

### Домени стања

| Домен | Механизам |
|---|---|
| Поредак ћелија | фракционо индексирање |
| Садржај ћелија | ОТ (централизована) |
| Позиције курсора | изведено из ОТ-а |
| Стање извршавања | серијализација |
| Присуство | без конфликата |

- Сваки домен се синхронизује независно
- Различите гаранције конзистентности по домену

----

### Поредак ћелија

<div class="row"><span class="lbl">обични индекси</span><div class="fi"><span>A 0</span><span class="new">X 1</span><span class="bad">B <s>1</s> 2</span><span class="bad">C <s>2</s> 3</span></div></div>
<div class="row fragment"><span class="lbl">фракциони</span><div class="fi"><span>A 0.2</span><span class="new">X 0.3</span><span>B 0.4</span><span>C 0.6</span></div></div>
<div class="row fragment"><span class="lbl">опет између</span><div class="fi"><span>A 0.2</span><span>X 0.3</span><span class="new">Y 0.35</span><span>B 0.4</span><span>C 0.6</span></div></div>
<div class="row fragment"><span class="lbl">конфликт</span><div class="fi"><span class="conc">А: X 0.3</span><span class="conc">Б: Z 0.3</span></div><span>→ сервер одлучује</span></div>

<div class="fragment">
<p><b>Уметање и премјештање мијењају само једну ћелију</b></p>
<p class="muted">Индекс је низ бајтова, не <em>float</em>: произвољна прецизност</p>
</div>

----

### Текст ћелија

<div class="sync">
<div class="box">
<b>Клијент</b>
<div class="op wait">на чекању: b</div>
<div class="muted">↓ послије потврде</div>
<div class="op sent">непотврђена: a</div>
</div>
<div class="mid">
<div class="fragment" data-fragment-index="0">a, основа v3 →</div>
<div class="fragment" data-fragment-index="2">← a', v6 (свима)</div>
</div>
<div class="box">
<b>Сервер: историја ћелије</b>
<div class="fi"><span>v3</span><span class="conc">v4</span><span class="conc">v5</span><span class="good fragment" data-fragment-index="2">v6 = a'</span></div>
<div class="muted fragment" data-fragment-index="1">a се трансформише кроз v4, v5</div>
</div>
</div>

Клијент: највише **једна непотврђена** и **једна на чекању**

Сервер: трансформише у односу на конкурентне измјене

<p class="muted">Курсори се помјерају кроз исте операције</p>

----

### Закључавање

<div class="sync">
<div class="box">
<b>Поредак ћелија</b> 🔒
<div class="fi"><span>A</span><span>B</span><span class="new">C ↕</span></div>
<div class="muted">премјештање</div>
</div>
<div class="box">
<b>Садржај ћелија</b>
<div class="fi"><span class="conc">A 🔒</span><span class="conc">B 🔒</span><span>C 🔒</span></div>
<div class="muted">истовремено куцање</div>
</div>
</div>

<ul>
<li>Текст и структура се не блокирају</li>
<li class="fragment"><b>Уметање:</b> нову ћелију још нико не види</li>
<li class="fragment"><b>Брисање:</b> измјена прије или послије → исто стање</li>
</ul>

---

## Извршавање кода

<div class="fi"><span class="conc">⏳ ћ3</span><span class="conc">⏳ ћ2</span><span class="arr">→</span><span class="new">⚙️ кернел: ▶ ћ1</span></div>
<p class="muted">једна ћелија у тренутку, редом</p>

<div class="fragment">
<div class="fi" style="font-size: 0.85em"><span>Слободна</span><span class="arr">→</span><span class="conc">⏳ У реду</span><span class="arr">→</span><span class="new">▶ Извршава се</span><span class="arr">→</span><span>Слободна</span></div>
<p class="muted">поново „покрени” док чека или ради → <span style="color: #d33">одбијено</span></p>
</div>

<ul>
<li class="fragment">Извршава се код из тренутка захтјева</li>
<li class="fragment"><b>Обрисана ћелија:</b> излаз се одбацује</li>
</ul>

---

## Закључак

- **Резултат:** пет независних, замјењивих механизама
- **Предности:** без _CRDT_ метаподатака, исто језгро на клијенту и серверу
- **Ограничења:** стање у меморији, једна биљежница
- **Будући рад:** постојаност, аутентификација, офлајн рад, _undo_

---

## Хвала на пажњи

Питања?

<p class="muted">github.com/Nikola352/crab-collab</p>
