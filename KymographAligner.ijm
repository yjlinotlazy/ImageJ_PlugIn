/* 
This plug re aligns a kymograph based on pseudo marks on the filament
Here's wow it works: 
now just set a range of pixels to search for lowest/highest intensity
get image length and width of kymograph
make a file with same width, and length + box size x 2
in the initial kymograph, at position i (ith picture) find the distance between center and the lowest pixel intensity, asign a modifier
re-align each line of kymograph according to modifier
*/

dir1 = getDirectory("Folder, temporary FOLDER!");

//image input
height=getHeight();
width=getWidth();
nFrames=height;
moreWidth=5;
modifierArray = newArray(nFrames+20);

//modifier = 0;	old

//user input
Dialog.create("How to align");
Dialog.addMessage("Align by what?");
Dialog.addNumber("by darkest(0) or brightest(1) pixels", 0)
Dialog.addNumber("Neighbourhood range in pixels", 5);
Dialog.show();
brightOrDark=Dialog.getNumber();
moreWidth=Dialog.getNumber();

oneMore=0;
wantSlope=0;
type=0;

waitForUser("Select a straight line along the region you want to align with");  
while (type !=5) {
	setTool("line"); 
	if (selectionType() != 5) {                           
	waitForUser("Pal, this is not a Straight line, try again");
		type=0;
	} else {
		type= 5;
	}
}


getSelectionBounds(xx, yy, wwidth, hheight);
/*FYI:
correlation between x and y of the line is: xk=x0+(yk-y0)*wwidth/hheight
x of the jth slice is
xj=xx+(j-yy)*wwidth/height
*/
centerX=xx+wwidth/2;

//search through a larger area if you need to. Not recommanded
if (wwidth>10) {
	moreWidth=wwidth;
}

centerX += moreWidth;

setBatchMode(true);
SplitKymograph(width, moreWidth, nFrames, dir1);

for (i=0; i<nFrames; i++){ //get location modifier of each kymo line
	modifierArray[i]=0; //default is 0
	//search for x-coordinate of the lowerest/highest pixel intensity in the neighbourhood
	//aslign that x-coordinate to the modifier of kymograph line i
	modifierArray[i]=ScanPixelsForLocationModifier(i, brightOrDark, centerX, moreWidth);
	makeRectangle(10+modifierArray[i], 0, width-10-modifierArray[i], 1);//make a rectangle selection

	run("Crop");
	run("Save");
}

//setBatchMode(false);
run("Images to Stack", "method=[Copy (top-left)] name=Stack title=[] use");
run("Make Montage...", "columns=1 rows=nFrames scale=1 first=1 last=nFrames increment=1 border=0 font=12");
//if (barbOrPointed==1){ 
//waitForUser("End");
//location of the mark
setBatchMode(false);

oneMore=getBoolean("Do you want to align another image the same way?");
while (oneMore==1) { //repeat the whole process
	waitForUser("SSAAVVEE the current image. Dont' close it!");
	t1=getTitle();
	waitForUser("Now open the next. (Still, Don't close the first one!)");
	t2=getTitle();
	selectWindow(t1);
	run("Close");
	
	setBatchMode(true);
	SplitKymograph(width, moreWidth, nFrames, dir1);
	
	for (i=0; i<nFrames; i++){ //use the previous location modifier on each kymo line
	nameM="L" + i+".tif";
	open(dir1 + nameM);
	makeRectangle(10+modifierArray[i], 0, width-10-modifierArray[i], 1);//make a rectangle selection

	run("Crop");
	run("Save");
	}
	
	run("Images to Stack", "method=[Copy (top-left)] name=Stack title=[] use");
	run("Make Montage...", "columns=1 rows=nFrames scale=1 first=1 last=nFrames increment=1 border=0 font=12");
	
	setBatchMode(false);
	oneMore=getBoolean("Do you want to align another image the same way?");
}

/////////////////Functions/////////////////

function SplitKymograph(widthw, moreWidthm, nFramesn, dir11) {
	newImage("Mock", "32-bit Black", widthw+2*moreWidthm, 1,1); //mock kymograph
	run("Images to Stack", "method=[Copy (center)] name=Stack title=[] use");
	setSlice(1);
	run("Delete Slice");

	for (i=0; i<nFramesn; i++){ //split kymographs into individual pictures
		makeRectangle(0, i, widthw, 1);
		run("Duplicate...", "title=A.tif");
		name1="L"+i;
		saveAs("Tiff", dir11 + name1);
		run("Close");
	}
	run("Close All");
}


function ScanPixelsForLocationModifier(window, desicion, center, more) {
	nameM="L" + window +".tif";
	open(dir1 + nameM);
	pixelL=getPixel(center,0); //defaul = center pixel, i.e. position unchanged
	
	modifier=0;
	if (desicion==0){ //find x-coordinate of lowerest intensity
		for(j=center-more;j<=center+more;j++) {
		pixelJ=getPixel(j,0);
		if(pixelJ<pixelL){
			pixelL=pixelJ;
			modifier=j-center;
			}
		}
	} else { //find x-coordinate of highest intensity
		for(j=center-more;j<=center+more;j++) {
		pixelJ=getPixel(j,0);
		if(pixelJ>pixelL){
			pixelL=pixelJ;
			modifier=j-center;
			}
		}
	}
	return modifier;
}
