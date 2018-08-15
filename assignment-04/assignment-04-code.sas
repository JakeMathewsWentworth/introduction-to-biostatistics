/* setup */
%web_drop_table(work.import);
filename datafile '/folders/myfolders/assignments/assignment-04/Data.csv';

proc import datafile = datafile 
			dbms = csv 
			out = work.import;
	getnames = yes;
run;

proc contents data=work.import;
run;

%web_open_table(work.import);


/* problem 1 */
proc summary data = work.import(where = (TimePoint = 0));
	class gender disease;
	var hc gl;
	types () gender * disease;
	output out = datasummary 
		n =
		mean(hc gl) =
		median(hc gl) =
		std(hc gl) =
		p25(hc gl) =
		p75(hc gl) = / 
		levels autoname;
run;

proc print;
run;


/* problem 2-a */
proc format;
	value age_format 
		80 - 90 = '80 to 90';
run;

proc summary data = work.import(where = (disease = 1 && timepoint = 1));
	class age / preloadfmt exclusive;
	var tr;
	output out = problem2out 
	idgroup(max(tr) out[5](tr patientid) = maxTR);
	format age age_format.;
run;

data problem2filtered;
	set problem2out(keep = Age maxTR_5 PatientId_5);

	if Age = . then
		delete;
run;

proc print;
run;


/* problem 2-b */
proc format;
	value agelevel 
		low -< 50 = 'less than 50';
run;

proc summary data = work.import(where = (disease = 1 && timepoint = 1));
	class age / preloadfmt exclusive;
	var cp;
	output out = problem2bout 
		idgroup(min(cp)out[4](cp patientid) = minCP);
	format age agelevel.;
run;

data problem2filtered;
	set problem2bout(keep = Age minCP_4 PatientId_4);

	if Age = . then
		delete;
run;

proc print;
run;


/* problem 3 */
proc format;
	value age_format 
		low -< 50 = 'less than 50' 
		50 - 70 = '50 to 70' 
		70 <- high ='70 to high';
	value tc_format 
		low -< 155 = 'less than 155' 
		155 -< 185 = '155 to less than 185' 
		185 -< 220 = '185 to less than 220' 
		220 - high = '220 to high';

proc freq data=work.import;
	tables age * tc / norow;
	format age age_format. tc tc_format.;
run;


/* problem 4-a */
ods select testsfornormality;

proc univariate data = work.import normaltest;
	var tc lc hc tr gl cp;
run;


/* problem 4-b */
ods select histogram;

proc univariate data = work.import;
	class timepoint;
	var hc;
	histogram / normal;
	inset n = 'N:' 
		mean = 'MEAN:' (4.2) 
		std = 'STD DEV:' (4.2) 
		skewness = 'SKEWNESS:' (4.2) / 
		position = ne 
		header = 'Summary Statistics';
run;


/* problem 4-d */
proc means data = work.import(where= (TimePoint = 0)) cv;
	var hc tr;
run;
