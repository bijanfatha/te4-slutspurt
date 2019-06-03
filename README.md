# Gymnasieingenjörsslutspurtsprojektsamlingsrepository

## Dependecies 

* sinatra, http://sinatrarb.com/documentation.html
* slim, http://slim-lang.com/
* rerun, https://github.com/alexch/rerun
* pg, https://bitbucket.org/ged/ruby-pg/wiki/Home
* mysql2, https://github.com/brianmario/mysql2
* i18n, https://github.com/ruby-i18n/i18n

## Whats left

### Sql injection:
Han inte göra om en trejde gång, 
stället gjorde stored procedures på direkten.
Det gjorde jag istället för prepered statments denna gång för att iprincip lära mig hur. Tänkte att det kanske hälper om jag skriver här varför man gör det osv. Anledningen bakom att säkra din kod från sql-injections är för att med detta kan hackermen komma åt din apps DB. Det kan de göra någonstans där du gör en query mot din db, ex login forum. Ett sätt att byspassa detta om du redan vet användarnamnet är att sätta lösen som: password='' or '1'='1'. Detta är alltid sant så det sker aldrig en password verification.

Anledning till att man kan göra SQL-injetions är för att man inte sätter restriktioner på user input. 

### Xss:
Xss är ännu et sätt för hacker manenen att leka med din hemsida. Det han 
gör är att hitta ett textfält på din hemsida och börjar skriva html kod. Ingen
ting skulle hända om skulle filtera dina outputs. Men om vi säger att du bara echo:ar tillbaka svaret som användarn sätter i textfältet e du fuckt.
Det riktigt faliga med detta är script taggen och det man kan göra med den och
när textfältet är länkad med datbasen.

