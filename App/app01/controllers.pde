
/* MANAGER */

class Controller extends EventTarget {
	HashMap<String,EventTarget> targets;
	Controller( int id_ ) {
		super( id_ );
		targets = new HashMap<String,EventTarget>();
	}
	
	void bind( EventSource source_, EventTarget target_ ) {
		source_.target = this;
		targets.put( str( source_.id ), target_ );
	}
}



class EventController extends Controller {

	EventController( int id_ ) {
		super( id_ );	
	}

	void trigger( EventMessage message_ ) { 
		int id = message_.id;
		String[] event = message_.event;
		EventTarget target = targets.get( str( id ) );
		println("trigger: " + target.id );
		target.trigger( message_ );
	}
}


