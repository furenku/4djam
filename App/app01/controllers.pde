
/* MANAGER */

class NodeController extends Node {
	
	HashMap< Integer, Node > nodes;
	HashMap< Integer, Routing > routings;
	// OscController oscController;
	int lastID;

	NodeController( int id_ ) {
		
		super( id_ );
		
		lastID = id_;

		nodes = new HashMap< Integer, Node>();
		routings = new HashMap< Integer, Routing>();

		setType("nodeController");
	}
	

	int nextID() {
		lastID++;
		return lastID;
	}


	void bind( Node source_, Node target_ ) {

		source_.controller = this;

		int id = nextID();
		Routing routing = new Routing( id );

		println( "bind " + source_.id + " to: " + target_.id );

		routing.setSource( source_ );
		routing.setTarget( target_ );

		routings.put( source_.id, routing );

	}


	void dumpRoutings() {
		for (int key_ : routings.keySet()) {
		    println( "key " + key_ );
		}

		for ( Routing value_ : routings.values()) {
		    println( "routed to " + value_.target.id );
		}
	}


	void trigger( Event event_ ) { 
		
		int id = event_.sourceID;
		Node target = routings.get( id ).target;

		target.trigger( event_ );

	}



	Node createNode( String type_, String name_ ) {
		
		int newID = nextID();
		
		Node node = new Node( newID, type_, name_ );
		nodes.put( newID, node );
		
		return node;

	}
	
	void removeNode( int id_ ) {
		nodes.remove( id_ );		
	}
	
}





 class OscController extends NodeController {

	OscController( int id_ ) {
		super( id_ );
		setType("osc");
	}

	OscSender oscSender;

	void setSender( OscSender oscSender_ ) {
		oscSender = oscSender_;
	}
	void bind( Node source_, Node target_ ) {
		super.bind( source_, target_ );
		oscSender.route( type, source_.id, target_.id );
	}



}





class ControlController extends NodeController {
	ControlController( int id_ ) {
		super( id_ );
		setType("control");
	}
}


class BusController extends OscController {
	BusController( int id_ ) {
		super( id_ );
		setType("bus");
	}
	
	Node createNode( String type_, String name_ ) {	
		Node node = super.createNode( type_, name_ );
		oscSender.createNode( "createBus", node.id, type_, name_ );
		return node;
	}
	
}



class SynthController extends OscController {
	SynthController( int id_ ) {
		super( id_ );
		setType("synth");
	}
	
	Node createNode( String type_, String name_ ) {	
		Node node = super.createNode( type_, name_ );
		oscSender.createNode( "createSynth", node.id, type_, name_ );
		return node;
	}
}




class AudioController extends OscController {
	AudioController	( int id_ ) {
		super( id_ );
		setType("audio");
		synths = new SynthController( id_ );
		busses = new BusController( id_ );
		controls = new ControlController( id_ );

		synths.setSender( oscSender );
	}

	void setSender( OscSender oscSender_ ) {
		super.setSender( oscSender_ );
		synths.setSender( oscSender_ );
		busses.setSender( oscSender_ );
	}
	
	SynthController synths;
	BusController busses;
	ControlController controls;
}
