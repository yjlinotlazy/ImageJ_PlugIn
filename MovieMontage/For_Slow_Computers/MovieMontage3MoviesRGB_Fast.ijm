//run("Clear Results");
//run("Close All")

dir0 = getDirectory("Master, I need an input folder");
dir1 = getDirectory("Master, I need a temporary folder");

setBatchMode(true);

open(dir0+"StackA.tif");
total=nSlices;

run("RGB Color");
for (i=1; i<=total; i++){
	setSlice(i);
	run("Duplicate...", "title=A");
	name1 = "A"+i;
	saveAs("Tiff", dir1 + name1);
	run("Close");
}
open(dir0+"StackB.tif");
run("RGB Color");
for (i=1; i<=total; i++){
	setSlice(i);
	run("Duplicate...", "title=B");
	name2 = "B"+i;
	saveAs("Tiff", dir1 + name2);
	run("Close");
}
open(dir0+"StackC.tif");
run("RGB Color");
for (i=1; i<=total; i++){
	setSlice(i);
	run("Duplicate...", "title=C");
	name3 = "C"+i;
	saveAs("Tiff", dir1 + name3);
	run("Close");
}

run("Close All");

for (i=1; i<=total; i++){
	name1="A"+i+".tif";
	name2="B"+i+".tif";
	name3="C"+i+".tif";
	open(dir1 + name1);
	open(dir1 + name2);
	open(dir1 + name3);
	run("Images to Stack", "name=Stack title=[]");
	run("Make Montage...", "columns=3 rows=1 scale=1 first=1 last=3 increment=1 border=1 font=12");
	nameM="Mont"+i;
	saveAs("Tiff", dir1 + nameM);
	run("Close All");
}
//setBatchMode(false);

for (i=1; i<=total; i++){
	nameM="Mont"+i+".tif";
	open(dir1 + nameM);
}
//setBatchMode(false);
run("Images to Stack", "name=Stack title=[]");
setBatchMode(false);

