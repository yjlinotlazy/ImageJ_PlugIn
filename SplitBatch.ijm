dir1 = getDirectory("Where do you want me to save images, Dear Master?");
dir2 = getDirectory("Show me the money");

list2 = getFileList(dir2);
setBatchMode(true);
for ( j =0 ; j<list2.length ; j++ ) {
	t = lastIndexOf(list2[j], ".");
	open(dir2+list2[j]);
	t=getTitle;
	run("Duplicate...", "title=red.tif duplicate range=1-4000");
	run("Slice Remover", "first=2 last=4000 increment=2");
	nameG="Green"+t;
	saveAs("Tiff", dir1+nameG);
	run("Close");
	nameR="Red"+t;
	run("Slice Remover", "first=1 last=4000 increment=2");
	saveAs("Tiff", dir1 + nameR);
	run("Close");
}





