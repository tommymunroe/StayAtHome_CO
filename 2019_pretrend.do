*Import Data and Clean

cd "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA"
import delimited "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA/daily_co2_2019.csv", clear

*Important Notes: Units of Measurement = PPM;

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
gen stayathome = statename=="Alabama" & inrange(date2,21643,.)==1
replace stayathome =1 if statename=="Alaska" & inrange(date2,21636,.)==1
replace stayathome =1 if statename=="Arizona" & inrange(date2,21639,.)==1
replace stayathome =1 if statename=="California" & inrange(date2,21627,.)==1
replace stayathome =1 if statename=="Colorado" & inrange(date2,21634,.)==1
replace stayathome =1 if statename=="Connecticut" & inrange(date2,21631,.)==1
replace stayathome =1 if statename=="Delaware" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="District of Columbia" & inrange(date2,21640,.)==1
replace stayathome =1 if statename=="Florida" & inrange(date2,21641,.)==1
replace stayathome =1 if statename=="Georgia" & inrange(date2,21642,.)==1
replace stayathome =1 if statename=="Hawaii" & inrange(date2,21633,.)==1
replace stayathome =1 if statename=="Idaho" & inrange(date2,21633,.)==1
replace stayathome =1 if statename=="Illinois" & inrange(date2,21629,.)==1
replace stayathome =1 if statename=="Indiana" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="Kansas" & inrange(date2,21638,.)==1
replace stayathome =1 if statename=="Kentucky" & inrange(date2,21634,.)==1
replace stayathome =1 if statename=="Louisiana" & inrange(date2,21631,.)==1
replace stayathome =1 if statename=="Maine" & inrange(date2,21641,.)==1
replace stayathome =1 if statename=="Maryland" & inrange(date2,21638,.)==1
replace stayathome =1 if statename=="Massachusetts" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="Michigan" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="Minnesota" & inrange(date2,21635,.)==1
replace stayathome =1 if statename=="Mississippi" & inrange(date2,21642,.)==1
replace stayathome =1 if statename=="Missouri" & inrange(date2,21645,.)==1
replace stayathome =1 if statename=="Montana" & inrange(date2,21636,.)==1
replace stayathome =1 if statename=="Nevada" & inrange(date2,21640,.)==1
replace stayathome =1 if statename=="New Hampshire" & inrange(date2,21635,.)==1
replace stayathome =1 if statename=="New Jersey" & inrange(date2,21629,.)==1
replace stayathome =1 if statename=="New Mexico" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="New York" & inrange(date2,21628,.)==1
replace stayathome =1 if statename=="North Carolina" & inrange(date2,21638,.)==1
replace stayathome =1 if statename=="Ohio" & inrange(date2,21631,.)==1
replace stayathome =1 if statename=="Oklahoma" & inrange(date2,21640,.)==1
replace stayathome =1 if statename=="Oregon" & inrange(date2,21631,.)==1
replace stayathome =1 if statename=="Pennsylvania" & inrange(date2,21640,.)==1
replace stayathome =1 if statename=="Rhode Island" & inrange(date2,21636,.)==1
replace stayathome =1 if statename=="South Carolina" & inrange(date2,21646,.)==1
replace stayathome =1 if statename=="Tennessee" & inrange(date2,21639,.)==1
replace stayathome =1 if statename=="Texas" & inrange(date2,21641,.)==1
replace stayathome =1 if statename=="Vermont" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="Virginia" & inrange(date2,21638,.)==1
replace stayathome =1 if statename=="Washington" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="West Virginia" & inrange(date2,21632,.)==1
replace stayathome =1 if statename=="Wisconsin" & inrange(date2,21633,.)==1

ren arithmeticmean carbonmonoxide

*Run a Regression!
reg carbonmonoxide stayathome, robust
xtset statecode date1
xtreg carbonmonoxide stayathome, fe vce(cluster statecode)
xtreg carbonmonoxide stayathome i.date1, cluster(statecode)

*Create Event Study
gen event = 21643 if statename == "Alabama"
replace event = 21636 if statename == "Alaska"
replace event = 21639 if statename == "Arizona"
replace event = 21627 if statename == "California"
replace event = 21634 if statename == "Colorado"
replace event = 21631 if statename == "Connecticut"
replace event = 21632 if statename == "Delaware"
replace event = 21640 if statename == "District of Columbia"
replace event = 21641 if statename == "Florida"
replace event = 21642 if statename == "Georgia"
replace event = 21633 if statename == "Hawaii"
replace event = 21633 if statename == "Idaho"
replace event = 21629 if statename == "Illinois"
replace event = 21632 if statename == "Indiana"
replace event = 21638 if statename == "Kansas"
replace event = 21634 if statename == "Kentucky"
replace event = 21631 if statename == "Louisiana"
replace event = 21641 if statename == "Maine"
replace event = 21638 if statename == "Maryland"
replace event = 21632 if statename == "Massachusetts"
replace event = 21632 if statename == "Michigan"
replace event = 21635 if statename == "Minnesota"
replace event = 21642 if statename == "Mississippi"
replace event = 21645 if statename == "Missouri"
replace event = 21636 if statename == "Montana"
replace event = 21640 if statename == "Nevada"
replace event = 21635 if statename == "New Hampshire"
replace event = 21629 if statename == "New Jersey"
replace event = 21632 if statename == "New Mexico"
replace event = 21628 if statename == "New York"
replace event = 21638 if statename == "North Carolina"
replace event = 21631 if statename == "Ohio"
replace event = 21640 if statename == "Oklahoma"
replace event = 21631 if statename == "Oregon"
replace event = 21640 if statename == "Pennsylvania"
replace event = 21636 if statename == "Rhode Island"
replace event = 21646 if statename == "South Carolina"
replace event = 21639 if statename == "Tennessee"
replace event = 21641 if statename == "Texas"
replace event = 21632 if statename == "Vermont"
replace event = 21638 if statename == "Virginia"
replace event = 21632 if statename == "Washington"
replace event = 21632 if statename == "West Virginia"
replace event = 21633 if statename == "Wisconsin"


gen eventtime = date2-event

forv i=-30/30{
	local name = subinstr("`i'","-","neg",1)
	gen e_`name' = eventtime==`i'
}
drop e_neg1

reg carbonmonoxide e_* i.statecode i.date1 if inrange(eventtime,-14,14)==1, cluster(statecode)

*Graphics (New York CO Levels Bar Graph)
twoway (bar carbonmonoxide stayathome if statename=="New York"), ytitle(Carbon Monoxide (ppm)) xtitle(Stay-at-Home Binary Variable) title(Carbon Monoxide Levels and Stay-at-Home Orders) subtitle(in New York State)

*Graphics (CO Levels Bar Graph)
twoway (bar carbonmonoxide stayathome if statename=="South Carolina"), ytitle(Carbon Monoxide (ppm)) xtitle(Stay-at-Home Binary Variable) title(Carbon Monoxide Levels and Stay-at-Home Orders) subtitle(in South Carolina)

*Event Study Graphic
use eventstudy_data2019.dta, clear
twoway (rarea upper lower etime) (connected est etime), ytitle(Effect on Carbon Monoxide Levels) xtitle(Event Time) title(Estimated 2019 Stay-at-Home Orders Event Study) subtitle(14 Days Before and After Supposed Stay-at-Home Orders) legend(label(1 "95% Confidence Interval") label(2 "Estimated Effect"))


*NY, SC, WY, Monthly CO Graphic
drop if statecode <=35
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
drop if statecode == 49
drop if statecode == 50
drop if statecode == 51
drop if statecode == 53
drop if statecode == 54
drop if statecode == 55

gen week = week(date1)
move week statename
collapse carbonmonoxide, by(week statecode statename stayathome)
sort statecode week
drop if week > 18
drop if week < 8

twoway (line carbonmonoxide week if statename=="New York", lcolor(magenta) lwidth(medium)) (line carbonmonoxide week if statename=="South Carolina", lcolor(orange_red) lwidth(medium)) (line carbonmonoxide week if statename=="Wyoming", lcolor(forest_green) lwidth(medium)), ytitle(Carbon Monoxide Levels) xtitle(Week) title(Carbon Monoxide Levels Over Time) subtitle(in Three States) legend( label(1 "New York") label(2 "South Carolina") label(3 "Wyoming"))


*USA Map
ssc install maptile
ssc install spmap
maptile_install using "http://files.michaelstepner.com/geo_state.zip"

***Event Day 5
drop if e_5 !=1
collapse carbonmonoxide, by(statename)
gen state = .
***Manually input state abbreviations
maptile carbonomonoxide, geo(state)

***Event Day -5
drop if e_neg5 !=1
collapse carbonmonoxide, by(statename)
gen state = .
***Manually input state abbreviations
maptile carbonmonoxide, geo(state)
