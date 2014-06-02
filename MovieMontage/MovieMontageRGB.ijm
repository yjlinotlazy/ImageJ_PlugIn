//run("Clear Results");
//run("Close All")

dir1 = getDirectory("Master, I need a temporary folder");
//dir2 = getDirectory("Master, I need an output folder");
selectWindow("StackA.tif");
total=nSlices;
run("RGB Color");
selectWindow("StackB.tif");
run("RGB Color");

setBatchMode(true);

for (i=1; i<=total; i++){
	selectWindow("StackA.tif");
	setSlice(i);
	run("Duplicate...", "title=A");
	name1 = "A"+i;
	saveAs("Tiff", dir1 + name1);
	run("Close");
	selectWindow("StackB.tif");
	setSlice(i);
	run("Duplicate...", "title=B");
	name2 = "B"+i;
	saveAs("Tiff", dir1 + name2);
	run("Close");
}

selectWindow("StackA.tif");
run("Close");
selectWindow("StackB.tif");
run("Close");

for (i=1; i<=total; i++){
	name1="A"+i+".tif";
	name2="B"+i+".tif";
	open(dir1 + name1);
	open(dir1 + name2);
	run("Images to Stack", "name=Stack title=[]");
	run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=1 font=12");
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

