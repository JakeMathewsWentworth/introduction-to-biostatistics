/* problem 1 */
proc means data=sashelp.cars mean std maxdec=0;
var msrp;
class type;
run;

/* problem 2 */
proc means data=sashelp.heart mean maxdec=0 n nmiss;
var cholesterol;
class sex;
run;

/* problem 3 */
proc means data=sashelp.heart mean min max maxdec=0 nonobs;
WHERE (chol_status='Borderline') or (chol_status='High');
var cholesterol;
class chol_status;
run;

/* problem 4 */
proc means data=sashelp.cars noprint;
var mpg_city mpg_highway;
class make;
output out=descripcars
	n(mpg_city mpg_highway)=
	mean(mpg_city mpg_highway)=
	median(mpg_city mpg_highway)=
	max(mpg_city mpg_highway)=
	min(mpg_city mpg_highway)=
	std(mpg_city mpg_highway)=
	range(mpg_city mpg_highway)=
	/ autoname;
run;
proc print data=descripcars;
run;

/* problem 5 */
proc format;
	value msrpformat
		low-<67000 = 'Low'
		67000-134000 = 'Medium'
		134000->high = 'High';
run;

proc freq data=sashelp.cars;
title 'Car MSRP Distribution by Make';
tables msrp*make / norow nocol;
format msrp msrpformat.;
run;



