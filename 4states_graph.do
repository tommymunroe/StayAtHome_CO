*Import Data and Clean

cd "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA"
import delimited "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA/daily_co2_2020.csv", clear

*Dropping Non-Useful Variables
drop methodcode parametercode latitude longitude datum parametername pollutantstandard poc sampleduration eventtype aqi methodname unitsofmeasure observationcount observationpercent sitenum countycode stmaxvalue stmaxhour localsitename address cbsaname dateoflastchange

*Change Date and Collapse
gen date1=date(datelocal,"YMD")
format date1 %td
move date1 datelocal
gen date2=date(datelocal, "YMD")

collapse arithmeticmean, by(date1 statecode date2 statename)
sort statecode date1
drop if statecode==72
gen month = month(date1)

*Generate Emergency Dummy Variables
gen stayathome = statename=="Alabama" & inrange(date2,22009,.)==1
replace stayathome =1 if statename=="Alaska" & inrange(date2,22002,.)==1
replace stayathome =1 if statename=="Arizona" & inrange(date2,22005,.)==1
replace stayathome =1 if statename=="California" & inrange(date2,21993,.)==1
replace stayathome =1 if statename=="Colorado" & inrange(date2,22000,.)==1
replace stayathome =1 if statename=="Connecticut" & inrange(date2,21997,.)==1
replace stayathome =1 if statename=="Delaware" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="District of Columbia" & inrange(date2,22006,.)==1
replace stayathome =1 if statename=="Florida" & inrange(date2,22007,.)==1
replace stayathome =1 if statename=="Georgia" & inrange(date2,22008,.)==1
replace stayathome =1 if statename=="Hawaii" & inrange(date2,21999,.)==1
replace stayathome =1 if statename=="Idaho" & inrange(date2,21999,.)==1
replace stayathome =1 if statename=="Illinois" & inrange(date2,21995,.)==1
replace stayathome =1 if statename=="Indiana" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="Kansas" & inrange(date2,22004,.)==1
replace stayathome =1 if statename=="Kentucky" & inrange(date2,22000,.)==1
replace stayathome =1 if statename=="Louisiana" & inrange(date2,21997,.)==1
replace stayathome =1 if statename=="Maine" & inrange(date2,22007,.)==1
replace stayathome =1 if statename=="Maryland" & inrange(date2,22004,.)==1
replace stayathome =1 if statename=="Massachusetts" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="Michigan" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="Minnesota" & inrange(date2,22001,.)==1
replace stayathome =1 if statename=="Mississippi" & inrange(date2,22008,.)==1
replace stayathome =1 if statename=="Missouri" & inrange(date2,22011,.)==1
replace stayathome =1 if statename=="Montana" & inrange(date2,22002,.)==1
replace stayathome =1 if statename=="Nevada" & inrange(date2,22006,.)==1
replace stayathome =1 if statename=="New Hampshire" & inrange(date2,22001,.)==1
replace stayathome =1 if statename=="New Jersey" & inrange(date2,21995,.)==1
replace stayathome =1 if statename=="New Mexico" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="New York" & inrange(date2,21994,.)==1
replace stayathome =1 if statename=="North Carolina" & inrange(date2,22004,.)==1
replace stayathome =1 if statename=="Ohio" & inrange(date2,21997,.)==1
replace stayathome =1 if statename=="Oklahoma" & inrange(date2,22006,.)==1
replace stayathome =1 if statename=="Oregon" & inrange(date2,21997,.)==1
replace stayathome =1 if statename=="Pennsylvania" & inrange(date2,22006,.)==1
replace stayathome =1 if statename=="Rhode Island" & inrange(date2,22002,.)==1
replace stayathome =1 if statename=="South Carolina" & inrange(date2,22012,.)==1
replace stayathome =1 if statename=="Tennessee" & inrange(date2,22005,.)==1
replace stayathome =1 if statename=="Texas" & inrange(date2,22007,.)==1
replace stayathome =1 if statename=="Vermont" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="Virginia" & inrange(date2,22004,.)==1
replace stayathome =1 if statename=="Washington" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="West Virginia" & inrange(date2,21998,.)==1
replace stayathome =1 if statename=="Wisconsin" & inrange(date2,21999,.)==1

ren arithmeticmean carbonmonoxide



*CA, SC, WY, MI: Monthly CO Graphic
drop if statecode < 6
drop if statecode == 8
drop if statecode == 9
drop if statecode == 10
drop if statecode == 11
drop if statecode == 12
drop if statecode == 13
drop if statecode == 15
drop if statecode == 16
drop if statecode == 17
drop if statecode == 18
drop if statecode == 19
drop if statecode == 20
drop if statecode == 21
drop if statecode == 22
drop if statecode == 23
drop if statecode == 24
drop if statecode == 25
drop if statecode == 26
drop if statecode == 28
drop if statecode == 29
drop if statecode == 30
drop if statecode == 31
drop if statecode == 32
drop if statecode == 33
drop if statecode == 34
drop if statecode == 35
drop if statecode == 36
drop if statecode == 37
drop if statecode == 38
drop if statecode == 39
drop if statecode == 40
drop if statecode == 41
drop if statecode == 42
drop if statecode == 44
drop if statecode == 46
drop if statecode == 47
drop if statecode == 48
drop if statecode > 49

gen week = week(date1)
move week statename
collapse carbonmonoxide, by(week statecode statename stayathome)
sort statecode week
drop if week > 18
drop if week < 8

twoway (line carbonmonoxide week if statename=="California", lcolor(magenta) lwidth(medium)) (line carbonmonoxide week if statename=="South Carolina", lcolor(orange_red) lwidth(medium)) (line carbonmonoxide week if statename=="Utah", lcolor(forest_green) lwidth(medium)) (line carbonmonoxide week if statename == "Minnesota", lcolor(blue)), ytitle(Carbon Monoxide Levels) xtitle(Week) title(Carbon Monoxide Levels Over Time) subtitle(in Three States) legend(label(1 "California") label(2 "South Carolina") label(3 "Utah") label(4 "Minnesota"))
