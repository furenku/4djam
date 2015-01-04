NodeController ctl = new NodeController( 1 );
OscSender osc = new OscSender();

void test() {

	// ctl.oscController = osc;

	Node eventSource = new Node( ctl.nextID() );
	Node eventTarget = new Node( ctl.nextID() );

	
	ctl.bind( eventSource, eventTarget );

	Node noteTarget = new Node( ctl.nextID() );
	Node ccTarget = new Node( ctl.nextID() );


	// ctl.bind( noteSource, synthPlayer );
	// ctl.bind( ccSource, ccTarget );



	Parameters parameters = new Parameters(0);

	Parameter parameter = new Parameter("testkey","testval");

	parameters.set( parameter );
	
	String [] pa = parameters.getParameterArray();

	for( String st : pa ) {
		println("STRING: "+ st );
	}

	eventSource.send( parameters );


	ctl.dumpRoutings();


	testAudioNodes();
}

Node synth1, synth2;

void testAudioNodes() {

	AudioController audio = new AudioController(0);


	audio.setSender( osc );
	Node bus1 = audio.busses.createBus();
	Node bus2 = audio.busses.createBus();
	
	audio.createOutput(0);
	audio.createOutput(1);
	
	synth1 = audio.synths.createSynth("testGen");
	synth2 = audio.synths.createSynth("testGen");
	

	synth1.set( "freq", 3 );

	//Node control = audio.controls.createNode( "audioBus", "bus_1" );
	

	// synth.addParameter("testKey","testVal");

	//println( "created control : " + control.id );


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
    super.exit();
}