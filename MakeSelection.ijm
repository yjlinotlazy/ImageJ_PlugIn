// Draw a oval around position (x, y)

Dialog.create("Y, X");
Dialog.addMessage("ok");

Dialog.addNumber("Y", 0);
Dialog.addNumber("X", 0);
Dialog.show();
yv = Dialog.getNumber();
xv = Dialog.getNumber();
makeOval(xv-50, yv-50, 100, 100);
Overlay.addSelection("cyan",5);

