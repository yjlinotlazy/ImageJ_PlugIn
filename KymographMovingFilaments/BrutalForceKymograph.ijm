dir1 = getDirectory("Master, I need a temporary folder");
total=nSlices;
t=getTitle;
total=getNumber("Number of ROIs", total);
barbOrPointed=getNumber("Tracing from the barbed(1) or pointed(0) end?", 0);
setBatchMode(true);
for (i=0; i<=total-1; i++){ //only because you need a stack (>=2 images) for the kymograph macro
	selectWindow(t);
	roiManager("Select", i);
	run("Duplicate...", "title=A.tif");
	run("Duplicate...", "title=B.tif");
	run("Concatenate...", "  title=[Concatenated Stacks] image1=A.tif image2=B.tif image3=[-- None --]");
	name1="L"+i;
	saveAs("Tiff", dir1 + name1);
	run("Close");
}
run("Close All")

for (ii=0; ii<=total-1; ii++){
	nameM="L" + ii+".tif";
	open(dir1 + nameM);
	roiManager("Select", ii);
	
///below completely copied from kymograph macro:
//http://www.embl.de/eamnet/downloads/macros/tsp050706.txt
	run("Set Slice...", "slice="+1);

	plotdata=getProfile();
	width=lengthOf(plotdata);
	height=nSlices;
	newimg="name=Kymograph width="+width+" height="+height+" slices=1";
	run("New...", newimg);kymo=getTitle();
	selectImage(nameM);

//	setBatchMode(false);
	for(i=1; i<nSlices+1; i++) {
		run("Restore Selection");
		plotdata=getProfile();
		selectImage(kymo);
		for(j=0; j<width; j++) {			
			setPixel(j,i-1,round(plotdata[j]));
		}
		selectImage(nameM);
		run("Next Slice [>]");
	}
	selectImage(kymo);
//	setBatchMode(false);
///above completely copied from kymograph macro
	nameK="Kymo"+ii;
	saveAs("Tiff", dir1 + nameK);
	run("Close All");
}
//setBatchMode(false);
for (ii=0; ii<=total-1; ii++){
	nameK="Kymo"+ii+".tif";
	open(dir1 + nameK);
	if (barbOrPointed==1){
		run("Flip Horizontally");
	}
}

// stack all the kymographs together!

run("Images to Stack", "method=[Copy (top-left)] name=Stack title=[] use");
run("Make Montage...", "columns=1 rows=total scale=1 first=1 last=total increment=1 border=0 font=12");
//if (barbOrPointed==1){ 
//	run("Flip Horizontally"); 
//}
selectWindow("Stack");
run("Close");
setBatchMode(false);
