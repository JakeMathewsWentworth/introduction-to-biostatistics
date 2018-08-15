/* Generated Code (IMPORT) */
/* Source File: CF.xlsx */
/* Source Path: /folders/myfolders/assignments/assignment-01 */
/* Code generated on: 5/14/18, 4:13 PM */

%web_drop_table(WORK.IMPORT1);


FILENAME REFFILE '/folders/myfolders/assignments/assignment-01/CF.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT1; RUN;

%web_open_table(WORK.IMPORT1);

proc print data = work.import1 (obs = 6); run;

data h; set import1;
length gender1 $6;
if gender = 1 then gender1 = "Male"; else gender1 = "Female";

proc freq data = h; tables hospital gender*gender1; 
proc sort data = h out = h1 nodupkey; by hospital;
proc print data = h1 (obs = 6) split = "*"; 
label gender1 = "Sex" hospital = "Hospital*ID";
run;

