void test() {
	EventSource src = new EventSource( 101 );
	EventTarget trgt = new EventTarget( 201 );

	EventController ctl = new EventController( 1 );

	ctl.bind( src, trgt );

//	src.target = trgt;

	String [] evt = { "uno", "dos" };

	src.send( evt );
}