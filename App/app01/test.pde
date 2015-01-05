NodeController ctl = new NodeController( 1 );
OscSender osc = new OscSender();

void test() {

	testAudioNodes();
	testPolyMode();

}

AudioController audio = new AudioController(0);
Node synth1, synth2;
Node polySynth, monoSynth;

void testAudioNodes() {



	audio.setSender( osc );
	Node bus1 = audio.busses.createBus();
	Node bus2 = audio.busses.createBus();
	
	Node output1 = audio.createOutput(0);
	Node output2 = audio.createOutput(1);
	
	// synth1 = audio.synths.createSynth("testGen","freq","2");
	
	// Parameters p = new Parameters();
	// p.set("freq","10");
	// p.set("rfreq","1000");
	// synth2 = audio.synths.createSynth("testGen", p);
	

	// audio.connect( synth1, output1 );
	// audio.connect( synth2, output2 );


	polySynth = audio.synths.createSynth("polyNote");
	audio.connect( polySynth, output1 );
	audio.connect( noteSource, polySynth );
	audio.synths.assignChannel( 0, polySynth );
	// Node control = audio.controls.createNode( "audioBus", "bus_1" );
	

	// synth.addParameter("testKey","testVal");

	// println( "created control : " + control.id );


/*
	audio.route("/nodeOut", bus.id, gen.id );
	audio.route("/nodeIn", bus.id, out.id );
*/
}


void testPolyMode() {
	
	

}
void mousePressed() {
	synth1.set( "freq", 3 );

	//testSendNoteOn(); 
}
void mouseReleased() {
	synth1.set( "freq", 2 );
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