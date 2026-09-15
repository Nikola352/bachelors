Презентација за одбрану рада, у [reveal-md](https://github.com/webpro/reveal-md) формату.

```sh
npm install -g reveal-md
reveal-md prezentacija.md          # презентовање у прегледачу (F — цео екран, S — биљешке)
reveal-md prezentacija.md --print prezentacija.pdf --print-size 1280x720
```

Дијаграми су у `media/dijagrami/`, генеришу се са [mermaid-cli](https://github.com/mermaid-js/mermaid-cli):

```sh
cd media/dijagrami && mmdc -i ot.mmd -o ../ot.png -s 3 -b white
mmdc -i sistem.mmd -o ../sistem.png -w 1600 -s 2 -b white   # широк дијаграм: шире платно
```
