//run("Clear Results");
//run("Close All")

dir0 = getDirectory("Master, I need an input folder");
dir1 = getDirectory("Master, I need a temporary folder");
//selectWindow("StackA.tif");
//total=nSlices;

setBatchMode(true);

open(dir0+"StackA.tif");
total=nSlices;

run("RGB Color");
for (i=1; i<=total; i++){
//	selectWindow("StackA.tif");
	setSlice(i);
	run("Duplicate...", "title=A");
	name1 = "A"+i;
	saveAs("Tiff", dir1 + name1);
	run("Close");
}
open(dir0+"StackB.tif");
run("RGB Color");
for (i=1; i<=total; i++){
//	selectWindow("StackB.tif");
	setSlice(i);
	run("Duplicate...", "title=B");
	name2 = "B"+i;
	saveAs("Tiff", dir1 + name2);
	run("Close");
}
open(dir0+"StackC.tif");
run("RGB Color");
for (i=1; i<=total; i++){
//	selectWindow("StackC.tif");
	setSlice(i);
	run("Duplicate...", "title=C");
	name3 = "C"+i;
	saveAs("Tiff", dir1 + name3);
	run("Close");
}
open(dir0+"StackD.tif");
run("RGB Color");
for (i=1; i<=total; i++){
//	selectWindow("StackD.tif");
	setSlice(i);
	run("Duplicate...", "title=D");
	name4 = "D"+i;
	saveAs("Tiff", dir1 + name4);
	run("Close");
}
open(dir0+"StackE.tif");
run("RGB Color");
for (i=1; i<=total; i++){
//	selectWindow("StackE.tif");
	setSlice(i);
	run("Duplicate...", "title=E");
	name5 = "E"+i;
	saveAs("Tiff", dir1 + name5);
	run("Close");

}

run("Close All");
setBatchMode(true);
for (i=1; i<=total; i++){
	name1="A"+i+".tif";
	name2="B"+i+".tif";
	name3="C"+i+".tif";
	name4="D"+i+".tif";
	name5="E"+i+".tif";
	open(dir1 + name1);
	open(dir1 + name2);
	open(dir1 + name3);
	open(dir1 + name4);
	open(dir1 + name5);
	run("Images to Stack", "name=Stack title=[]");
	run("Make Montage...", "columns=5 rows=1 scale=1 first=1 last=5 increment=1 border=1 font=12");
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

