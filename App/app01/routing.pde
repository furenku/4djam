class EventRouting extends BaseClass {

	EventSource src;
	EventTarget target;

	EventRouting( int id_ ) {
		super( id_ );
	}

	void connect( EventSource src_, EventTarget target_ ) {
		setSource( src_ );
		setTarget( target_ );
	}


	void setSource( EventSource src_ ) {
		src = src_;
	}


	void setTarget( EventTarget target_ ) {
		target = target_;
	}



}