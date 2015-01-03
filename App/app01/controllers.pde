
/* MANAGER */

class NodeController extends Node {
	
	HashMap< Integer, Node > nodes;
	HashMap< Integer, Routing > routings;
	// OscController oscController;
	int lastID;

	NodeController( int id_ ) {
		
		super( id_ );
		
		lastID = id_;
		routings = new HashMap< Integer, Routing>();
	}
	

	int nextID() {
		lastID++;
		return lastID;
	}


	void bind( String type_, Node source_, Node target_ ) {

		source_.controller = this;

		int id = nextID();
		Routing routing = new Routing( id );

		println( "bind " + source_.id + " to: " + target_.id );

		routing.setSource( source_ );
		routing.setTarget( target_ );

		routings.put( source_.id, routing );

		//oscController.route( type_, source_.id, target_.id );

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
		
		//oscController.createNode( newID, type_, name_ );

		return node;

	}
	
	void removeNode( int ID_ ) {
		nodes.remove( ID_ );		
	}
	


	


	

	

	



}


