



void test() {

	EventController ctl = new EventController( 1 );

	EventSource eventSource = new EventSource( 102 );
	EventTarget eventTarget = new EventTarget( 201 );
	
	ctl.bind( eventSource, eventTarget );

	EventTarget noteTarget = new EventTarget( 202 );


	println( eventSource.id + ", " + eventTarget.id  + ", " +  noteSource.id + ", " +  noteTarget.id );

	ctl.bind( noteSource, noteTarget );


	String [] evt = { "uno", "dos" };
	eventSource.send( evt );


}