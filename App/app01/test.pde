NodeController ctl = new NodeController( 1 );
OscSender osc = new OscSender();

void test() {

	testAudioNodes();

}

Node synth1, synth2;

void testAudioNodes() {

	AudioController audio = new AudioController(0);


	audio.setSender( osc );
	Node bus1 = audio.busses.createBus();
	Node bus2 = audio.busses.createBus();
	
	Node output1 = audio.createOutput(0);
	Node output2 = audio.createOutput(1);
	
	synth1 = audio.synths.createSynth("testGen");
	synth2 = audio.synths.createSynth("testGen","freq","10");
	

	synth1.set( "freq", 3 );

	audio.connect( synth1, output1 );
	audio.connect( synth2, output2 );


	audio.connect( noteSource, synth1 );
	// Node control = audio.controls.createNode( "audioBus", "bus_1" );
	

	// synth.addParameter("testKey","testVal");

	// println( "created control : " + control.id );


/*
	audio.route("/nodeOut", bus.id, gen.id );
	audio.route("/nodeIn", bus.id, out.id );
*/
}



void mousePressed() {
	synth1.set( "freq", 3 );

	//testSendNoteOn(); 
}
void mouseReleased() {

	testSendNoteOn(); 
}
void testSendNoteOn() {
	println("impl. test send note on");
	// aC.note();
}
void testSendNoteOff() {
	println("impl. test send note off");
}

void exit()
{
    // synthPlayer.freeSynth();
    osc.freeAll();
    super.exit();
}