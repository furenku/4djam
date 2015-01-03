EventController ctl = new EventController( 1 );

// MonoSynth synthPlayer = new MonoSynth( ctl.nextID() );


void test() {

	//synthPlayer.createSynth();

	EventSource eventSource = new EventSource( ctl.nextID() );
	EventTarget eventTarget = new EventTarget( ctl.nextID() );

	
	ctl.bind( eventSource, eventTarget );

	EventTarget noteTarget = new EventTarget( ctl.nextID() );
	EventTarget ccTarget = new EventTarget( ctl.nextID() );


	// ctl.bind( noteSource, synthPlayer );
	// ctl.bind( ccSource, ccTarget );



	Parameters parameters = new Parameters();

	Parameter parameter = new Parameter("testkey","testval");

	parameters.addParameter( parameter );
	
	eventSource.trigger( parameters );


	ctl.dumpRoutings();


	testAudioToOsc();

}


void testAudioToOsc() {
	AudioController aC = new AudioController();
	OscController oC = new OscController();
	aC.oscController = oC;

	AudioNode bus = aC.createBus();
	AudioNode out = aC.createAudioNode( "synth", "output");
	AudioNode gen = aC.createAudioNode( "synth", "testGen");

	println( "created bus: " + bus.id );
	println( "created gen node: " + gen.id );
	println( "created out node: " + out.id );
	aC.audioRoute("/nodeOut", bus.id, gen.id );
	aC.audioRoute("/nodeIn", bus.id, out.id );

}

void exit()
{
    // synthPlayer.freeSynth();
    super.exit();
}