class EventRouting extends BaseClass {


	EventSource source;
	EventTarget target;



	EventRouting( int id_ ) {
		super( id_ );
	}



	void connect( EventSource source_, EventTarget target_ ) {
		setSource( source_ );
		setTarget( target_ );
	}

	void setSource( EventSource source_ ) {
		source = source_;
	}
	void setTarget( EventTarget target_ ) {
		target = target_;
	}



}