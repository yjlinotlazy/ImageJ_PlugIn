//run("Clear Results");
//run("Close All")

dir1 = getDirectory("Master, I need a temporary folder");
selectWindow("GreenStack.tif");
run("Green");
run("RGB Color");
total=nSlices;

selectWindow("RedStack.tif");
run("Red");
run("RGB Color");

setBatchMode(true);

for (i=1; i<=total; i++){
	selectWindow("GreenStack.tif");
	setSlice(i);
	run("Duplicate...", "title=Green");
	selectWindow("RedStack.tif");
	setSlice(i);
	run("Duplicate...", "title=Red");
	run("Merge Channels...", "c1=Red c2=Green keep");
	name3 = "RGB"+i;
	saveAs("Tiff", dir1 + name3);
	run("Close");
	selectWindow("Green");
	name1 = "Green"+i;
	saveAs("Tiff", dir1 + name1);
	run("Close");
	selectWindow("Red");
	name2 = "Red"+i;
	saveAs("Tiff", dir1 + name2);
	run("Close");
}

selectWindow("GreenStack.tif");
run("Close");
selectWindow("RedStack.tif");
run("Close");

for (i=1; i<=total; i++){
	nameG="Green"+i+".tif";
	nameR="Red"+i+".tif";
	nameRGB="RGB"+i+".tif";
	open(dir1 + nameG);
	open(dir1 + nameR);
	open(dir1 + nameRGB);
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
run("Images to Stack", "name=Stack title=[]");
setBatchMode(false);



