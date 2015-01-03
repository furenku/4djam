NodeController ctl = new NodeController( 1 );
OscController osc = new OscController();

void test() {

	// ctl.oscController = osc;

	Node eventSource = new Node( ctl.nextID() );
	Node eventTarget = new Node( ctl.nextID() );

	
	ctl.bind( "control", eventSource, eventTarget );

	Node noteTarget = new Node( ctl.nextID() );
	Node ccTarget = new Node( ctl.nextID() );


	// ctl.bind( noteSource, synthPlayer );
	// ctl.bind( ccSource, ccTarget );



	Parameters parameters = new Parameters();

	Parameter parameter = new Parameter("testkey","testval");

	parameters.addParameter( parameter );
	
	ArrayList<String> pa = parameters.getParameterArray();

	for( String st : pa ) {
		println("STRING: "+ st );
	}

	eventSource.send( parameters );


	ctl.dumpRoutings();


	// testAudioToOsc();
	testNodes();
}


void testNodes() {

	NodeController busses = new NodeController(1);
	NodeController synths = new NodeController(2);
	NodeController control = new NodeController(3);
}
/*
AudioController aC;
OscController oC;

void testAudioToOsc() {

	aC = new AudioController();
	oC = new OscController();

	aC.oscController = oC;
	AudioNode bus = aC.createBus();
	AudioNode out = aC.createAudioNode( "synth", "output");
	AudioNode gen = aC.createAudioNode( "synth", "testGen");

	println( "created bus: " + bus.id );
	println( "created gen node: " + gen.id );
	println( "created out node: " + out.id );

	aC.route("/nodeOut", bus.id, gen.id );
	aC.route("/nodeIn", bus.id, out.id );

}
*/


void mousePressed() {

	testSendNoteOn(); 
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
    super.exit();
}