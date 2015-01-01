
/* MANAGER */

class EventController extends EventTarget {
	
	HashMap< Integer, EventSource > sources;
	HashMap< Integer, EventTarget > targets;
	HashMap< Integer, EventRouting > routings;

	EventController( int id_ ) {
		super( id_ );
		targets = new HashMap< Integer, EventTarget>();
	}
	
	void bind( EventSource source_, EventTarget target_ ) {
		source_.controller = this;

		println( "bind " + source_.id + "to: " + target_.id );

		targets.put( source_.id, target_ );

		for (int key_ : targets.keySet()) {
		    println( "key " + key_ );
		}

		for ( EventTarget target__ : targets.values()) {
		    println( "target " + target__.id );
		}
	}

	void trigger( EventMessage message_ ) { 
		int id = message_.id;
		EventTarget target = targets.get( id );

		String[] event = message_.event;

		println("trigger: " + target.id );
		target.trigger( message_ );

	}

}


