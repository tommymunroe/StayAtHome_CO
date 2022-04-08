*Import Data and Clean

cd "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA"
import delimited "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA/daily_co2_2020.csv", clear

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

*Create Event Study
gen event = 22009 if statename == "Alabama"
replace event = 22002 if statename == "Alaska"
replace event = 22005 if statename == "Arizona"
replace event = 21993 if statename == "California"
replace event = 22000 if statename == "Colorado"
replace event = 21997 if statename == "Connecticut"
replace event = 21998 if statename == "Delaware"
replace event = 22006 if statename == "District of Columbia"
replace event = 22007 if statename == "Florida"
replace event = 22008 if statename == "Georgia"
replace event = 21999 if statename == "Hawaii"
replace event = 21999 if statename == "Idaho"
replace event = 21995 if statename == "Illinois"
replace event = 21998 if statename == "Indiana"
replace event = 22004 if statename == "Kansas"
replace event = 22000 if statename == "Kentucky"
replace event = 21997 if statename == "Louisiana"
replace event = 22007 if statename == "Maine"
replace event = 22004 if statename == "Maryland"
replace event = 21998 if statename == "Massachusetts"
replace event = 21998 if statename == "Michigan"
replace event = 22001 if statename == "Minnesota"
replace event = 22008 if statename == "Mississippi"
replace event = 22011 if statename == "Missouri"
replace event = 22002 if statename == "Montana"
replace event = 22006 if statename == "Nevada"
replace event = 22001 if statename == "New Hampshire"
replace event = 21995 if statename == "New Jersey"
replace event = 21998 if statename == "New Mexico"
replace event = 21994 if statename == "New York"
replace event = 22004 if statename == "North Carolina"
replace event = 21997 if statename == "Ohio"
replace event = 22006 if statename == "Oklahoma"
replace event = 21997 if statename == "Oregon"
replace event = 22006 if statename == "Pennsylvania"
replace event = 22002 if statename == "Rhode Island"
replace event = 22012 if statename == "South Carolina"
replace event = 22005 if statename == "Tennessee"
replace event = 22007 if statename == "Texas"
replace event = 21998 if statename == "Vermont"
replace event = 22004 if statename == "Virginia"
replace event = 21998 if statename == "Washington"
replace event = 21998 if statename == "West Virginia"
replace event = 21999 if statename == "Wisconsin"


gen eventtime = date2-event

forv i=-30/30{
	local name = subinstr("`i'","-","neg",1)
	gen e_`name' = eventtime==`i'
}
drop e_neg1

gen CO14 = carbonmonoxide if e_14 == 1
gen COneg14 = carbonmonoxide if e_neg14 == 1

drop if e_14 != 1 & e_neg14 != 1


**Had to manually copy and paste CO14 into the blank box above it so that the next command would work
drop if COneg14 ==.
gen CO_change = CO14 - COneg14
drop if CO_change ==.


*USA Map
ssc install maptile
ssc install spmap
maptile_install using "http://files.michaelstepner.com/geo_state.zip"
maptile_install using "http://files.michaelstepner.com/geo_statehex.zip"
**Had to make folder "ado" and then "personal" when following the file path (the folders didn't exist before)

***Event Map Difference
collapse CO_change, by(statename)
gen state =.
*Manually input state abbreviations into state variable
maptile CO_change, geo(state)




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

***Event Day 14
drop if e_14 != 1
collapse carbonmonoxide, by(statename)
gen state =.
maptile carbonmonoxide, geo(state)

***Event Day -14
drop if e_neg14 != 1
collapse carbonmonoxide, by(statename)
gen state =.
maptile carbonmonoxide, geo(state)
