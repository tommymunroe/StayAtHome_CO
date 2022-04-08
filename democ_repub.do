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

**Gen Repub/Democ Variables
gen repub = 0
	replace repub = 1 if statename == "Alabama"
	replace repub = 1 if statename == "Alaska"
	replace repub = 1 if statename == "Arkansas"
	replace repub = 1 if statename == "Florida"
	replace repub = 1 if statename == "Idaho"
	replace repub = 1 if statename == "Iowa"
	replace repub = 1 if statename == "Indiana"
	replace repub = 1 if statename == "Kansas"
	replace repub = 1 if statename == "Kentucky"
	replace repub = 1 if statename == "Louisiana"
	replace repub = 1 if statename == "Mississippi"
	replace repub = 1 if statename == "Missouri"
	replace repub = 1 if statename == "Montana"
	replace repub = 1 if statename == "Nebraska"
	replace repub = 1 if statename == "North Carolina"
	replace repub = 1 if statename == "North Dakota"
	replace repub = 1 if statename == "Ohio"
	replace repub = 1 if statename == "Oklahoma"
	replace repub = 1 if statename == "South Carolina"
	replace repub = 1 if statename == "South Dakota"
	replace repub = 1 if statename == "Tennessee"
	replace repub = 1 if statename == "Texas"
	replace repub = 1 if statename == "Utah"
	replace repub = 1 if statename == "West Virginia"
	replace democ = 1 if statename == "Wyoming"
gen democ = 0
	replace democ = 1 if statename == "Arizona"
	replace democ = 1 if statename == "California"
	replace democ = 1 if statename == "Colorado"
	replace democ = 1 if statename == "Connecticut"
	replace democ = 1 if statename == "Delaware"
	replace democ = 1 if statename == "District of Columbia"
	replace democ = 1 if statename == "Georgia"
	replace democ = 1 if statename == "Hawaii"
	replace democ = 1 if statename == "Illinois"
	replace democ = 1 if statename == "Maine"
	replace democ = 1 if statename == "Maryland"
	replace democ = 1 if statename == "Massachusetts"
	replace democ = 1 if statename == "Michigan"
	replace democ = 1 if statename == "Minnesota"
	replace democ = 1 if statename == "Nevada"
	replace democ = 1 if statename == "New Hampshire"
	replace democ = 1 if statename == "New Jersey"
	replace democ = 1 if statename == "New Mexico"
	replace democ = 1 if statename == "New York"
	replace democ = 1 if statename == "Oregon"
	replace democ = 1 if statename == "Pennsylvania"
	replace democ = 1 if statename == "Rhode Island"
	replace democ = 1 if statename == "Virginia"
	replace democ = 1 if statename == "Vermont"
	replace democ = 1 if statename == "Washington"
	replace democ = 1 if statename == "Wisconsin"
	
**Regression Time!
reg carbonmonoxide stayathome repub, robust
