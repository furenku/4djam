
/* MANAGER */

class EventController extends EventTarget {
	
	HashMap< Integer, EventSource > sources;
	//HashMap< Integer, EventTarget > targets;
	HashMap< Integer, EventRouting > routings;
	
	int lastID;

	EventController( int id_ ) {
		super( id_ );
		
		lastID = id_;

		routings = new HashMap< Integer, EventRouting>();
	}
	

	int nextID() {
		lastID++;
		return lastID;
	}


	void bind( EventSource source_, EventTarget target_ ) {

		source_.controller = this;

		int id = nextID();
		EventRouting routing = new EventRouting( id );

		println( "bind " + source_.id + "to: " + target_.id );

		routing.setSource( source_ );
		routing.setTarget( target_ );

		routings.put( source_.id, routing );

	}


	void dumpRoutings() {
		for (int key_ : routings.keySet()) {
		    println( "key " + key_ );
		}

		for ( EventRouting value_ : routings.values()) {
		    println( "routed to " + value_.target.id );
		}
	}


	void trigger( Event event_ ) { 
		
		int id = event_.sourceID;
		EventTarget target = routings.get( id ).target;

		target.trigger( event_ );

	}

}


