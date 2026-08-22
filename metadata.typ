#let format_strane = "a4"         // могуће вредности: iso-b5, a4
#let naslov = "Колаборативна " + [_Jupyter_] + " биљежница са подршком за уређивање и извршавање у реалном времену"
#let autor = "Никола Јоловић"

// На енглеском
#let naslov_eng = "A Collaborative Jupyter Notebook with real-time editing and execution support"
#let autor_eng = "Nikola Jolović"

#let indeks = "SV9/2022"

// Име и презиме ментора
#let mentor = "Игор Дејановић"
// Звање: редовни професор, ванредни професор, доцент
#let mentor_zvanje = "редовни професор"

// Скинути коментаре са одговарајућих линија
#let studijski_program = "Софтверско инжењерство и информационе технологије"
//#let studijski_program = "Рачунарство и аутоматика"
//#let stepen = "Мастер академске студије"
#let stepen = "Основне академске студије"

#let godina = [#datetime.today().year()]

#let kljucne_reci = "Jupyter биљежница, сарадња у реалном времену, " + [_CRDT_] + ", Операционе трансформације"
#let apstrakt = [
     Овај рад представља студију случаја софтвера _Crab Collab_, колаборативне _Jupyter_ биљежнице. _Crab Collab_ омогућава да више корисника уређују један документ у реалном времену, уз одржавање конзистентног погледа за све кориснике.
     Архитектура са централним сервером омогућава дијељење окружења за извршавање кода и пружа гаранције потребне за синхронизацију стања.
     Представљено рјешење користи структуру документа типа биљежнице да комбинује приступе за разрјешавање конфликата засноване на операционим трансформацијама и фракционом индексирању ради постизања конзистентности.
]

// На енглеском
#let kljucne_reci_eng = "Jupyter notebook, real-time collaboration, CRDT, Operational transformation"
#let apstrakt_eng = [
     This thesis presents a case study of _Crab Collab_, a collaborative _Jupyter_ notebook. _Crab Collab_ allows multiple users to edit one document in real-time, while maintaining a consistent view for all users.
     Architecture with a central server allows sharing a code execution environment and provides guarantees required for state synchronization.
     The presented solution utilizes notebook document structure to combine conflict resolution strategies based on operational transformations and fractional indexing to achieve consistency.
]

// TODO: Текст задатка добијате од ментора. Заменити доле #lorem(100) са текстом задатка.
#let zadatak = [
     #lorem(100)
]

// TODO: Датум одбране и чланове комисије добијате од ментора
#let datum_odbrane = "01.01.2025"
#let komisija_predsednik = "Петар Петровић"
#let komisija_predsednik_zvanje = "ванредни професор"
#let komisija_clan = "Марко Марковић"
#let komisija_clan_zvanje = "доцент"

// На енглеском уписати чланове на латиници
#let komisija_predsednik_eng = "Petar Petrović"
#let komisija_clan_eng = "Marko Marković"
#let mentor_eng = "Igor Dejanović"


// Ово даље углавном не треба мењати.

#let zvanje_eng = (
     "редовни професор": "full professor",
     "ванредни професор": "assoc. professor",
     "доцент": "asist. professor",
)
#let komisija_predsednik_zvanje_eng = zvanje_eng.at(komisija_predsednik_zvanje)
#let komisija_clan_zvanje_eng = zvanje_eng.at(komisija_clan_zvanje)
#let mentor_zvanje_eng = zvanje_eng.at(mentor_zvanje)


#let vrsta_rada = if stepen == "Мастер академске студије" {
    "Дипломски - мастер рад"
} else {
    "Дипломски - бечелор рад"
}

#let oblast = "Електротехничко и рачунарско инжењерство"
#let oblast_eng = "Electrical and Computer Engineering"
#let disciplina = "Примењене рачунарске науке и информатика"
#let disciplina_eng = "Applied computer science and informatics"

#import "funkcije.typ": *
// Поглавља/страна/цитата/табела/слика/графика/прилога
#let fizicki_opis = physical()
