// Measure fluorescence over time on a given ROI

frame1=getNumber("first frame", 1);
frame2=getNumber("last frame", 5);
//setBatchMode(true);
for (i=frame1; i<=frame2; i++){
	run("Measure");
	run("Next Slice [>]");
}

