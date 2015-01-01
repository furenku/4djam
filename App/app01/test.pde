EventController ctl = new EventController( 1 );

MonoSynth synthPlayer = new MonoSynth( ctl.nextID() );


void test() {

	synthPlayer.createSynth();

	EventSource eventSource = new EventSource( ctl.nextID() );
	EventTarget eventTarget = new EventTarget( ctl.nextID() );

	
	ctl.bind( eventSource, eventTarget );

	EventTarget noteTarget = new EventTarget( ctl.nextID() );
	EventTarget ccTarget = new EventTarget( ctl.nextID() );


	ctl.bind( noteSource, synthPlayer );
	ctl.bind( ccSource, ccTarget );



	Parameters parameters = new Parameters();

	Parameter parameter = new Parameter("testkey","testval");

	parameters.addParameter( parameter );
	
	eventSource.trigger( parameters );


	ctl.dumpRoutings();

}


void exit()
{
    synthPlayer.freeSynth();
    super.exit();
}