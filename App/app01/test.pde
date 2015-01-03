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



	Parameters parameters = new Parameters();

	Parameter parameter = new Parameter("testkey","testval");

	parameters.addParameter( parameter );
	
	ArrayList<String> pa = parameters.getParameterArray();

	for( String st : pa ) {
		println("STRING: "+ st );
	}

	eventSource.send( parameters );


	ctl.dumpRoutings();


	testAudioNodes();
}


void testAudioNodes() {

	AudioController audio = new AudioController(0);


	audio.setSender( osc );
	Node bus = audio.busses.createNode( "audioBus", "bus_1" );
	Node synth = audio.synths.createNode( "audioBus", "bus_1" );
	Node control = audio.controls.createNode( "audioBus", "bus_1" );
	
	println( "created bus : " + bus.id );
	println( "created synth : " + synth.id );
	println( "created control : " + control.id );
/*
	audio.route("/nodeOut", bus.id, gen.id );
	audio.route("/nodeIn", bus.id, out.id );
*/
}



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