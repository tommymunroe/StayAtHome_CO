cd "/Users/scoobertdoobert/Desktop/school/QAMO 3040/Final Project/DATA"
use eventstudy_data2019.dta, clear

***Graphic
twoway (rarea upper lower etime) (connected est etime), ytitle(Effect on Carbon Monoxide Levels) xtitle(Event Time) title(Event Study 2019 PreTrend) subtitle(14 Days Before and After Stay-at-Home Orders One Year Earlier) legend(label(1 "95% Confidence Interval") label(2 "Estimated Effect"))
