// import supercollider.*;
import oscP5.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

KeyboardManager keyboard;


import netP5.*;





void setup(){

size(600, 400);
smooth();
noStroke();
background(255);

	keyboard = new KeyboardManager();  

	setupMIDI();
	test();

	initOsc();


}
int counter = 0;
void draw() {

	counter++;
	counter%=10;
	if(counter==0) {
		println("send OSC");
		float freq = map(mouseY, 0, height, 1500, 100);
		//map mouseX to fit panning range
		float pos = map(mouseX, 0, width, -1.0, 1.0);
		//this section creates/formats/sends the OSC message to SC

	}	
}



void initOsc() {
	
}

void oscEvent(OscIn theOscIn) {
	println("recieved");
} 