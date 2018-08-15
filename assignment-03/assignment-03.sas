/* problem 1 */
proc summary data = sashelp.cars(where = (cylinders in(4, 6, 8))) completetypes;
	class cylinders make type;
	var msrp;
	types () cylinders * (make type);
	output out = 
		carSummary mean(msrp) =/ 
		autoname;
run;

proc print data = work.carSummary;
run;


/* problem 2 */
proc summary data = sashelp.cars(where = (origin = 'USA'));
	class make type origin;
	var msrp;
	output out =
		carsummry n =
		mean(msrp) =
		min(msrp) =
		minid(msrp(model)) =/ 
		autoname;
run;

proc print data=work.carsummry;
run;


/* problem 3 */
proc summary data=sashelp.cars(where = (type in ('SUV', 'Sedan')));
	class make type;
	var mpg_city;
	output out =
		carsummry n =
		mpg_city_n mean(mpg_city) = mpg_city_mean 
		max(mpg_city) = mpg_city_max
		idgroup(max(mpg_city) out[2](mpg_city model) = maxMPG_city);
run;

proc print data = work.carsummry;
run;


/* problem 4 */
proc format;
	value cylinders_format
		low - 6 = 'Group 1' 
		7 - high = 'Group 2';
run;

proc summary data=sashelp.cars;
	class type cylinders/groupinternal;
	var msrp;
	output out = carsummry mean=/ autoname;
	format cylinders cylinders_format.;
run;

proc print data = work.carsummry;
run;


/* problem 5 */
proc format;
	value weight_format 
		low -< 6000 = 'Class 1' 
		6000 - 10000 = 'Class 2' 
		10000 <- high = 'Class 3 or higher';
run;

proc summary data=sashelp.cars completetypes;
	class type weight / preloadfmt;
	var msrp;
	output out =
		carsummry mean=/ 
		autoname;
	format weight weight_format.;
run;

proc print data = work.carsummry;
run;