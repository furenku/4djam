


EventController ctl = new EventController( 1 );

void test() {


	EventSource eventSource = new EventSource( ctl.nextID() );
	EventTarget eventTarget = new EventTarget( ctl.nextID() );
	
	ctl.bind( eventSource, eventTarget );

	EventTarget noteTarget = new EventTarget( ctl.nextID() );


	println( eventSource.id + ", " + eventTarget.id  + ", " +  noteSource.id + ", " +  noteTarget.id );

	ctl.bind( noteSource, noteTarget );



	Parameters parameters = new Parameters();

	Parameter parameter = new Parameter("testkey","testval");

	parameters.addParameter( parameter );
	
	eventSource.trigger( parameters );


	ctl.dumpRoutings();

}