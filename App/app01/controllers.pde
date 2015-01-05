class OscController extends NodeController {

	OscController( int id_ ) {
		super( id_ );
		setType("osc");
	}

	OscSender oscSender;

	void setSender( OscSender oscSender_ ) {
		oscSender = oscSender_;
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
	
	Node createBus() {			
		Node node = createNode();
		oscSender.createNode( node.id, node.type, node.name );
		return node;
	}
	
	Node createBus( int channel_ ) {			
		Node node = createNode( channel_ );
		String [] parameters = { "outBus", str( channel_) };
		oscSender.createNode( node.id, "outBus", node.name, parameters );
		return node;
	}
}





class SynthController extends OscController {
	SynthController( int id_ ) {
		super( id_ );
		setType("synth");
	}
	
	Node createSynth( String name_ ) {			
		Node node = createNode( name_ );
		oscSender.createNode( node.id, node.type, node.name );
		return node;
	}
	Node createSynth( String name_, Parameter parameter_ ) {
	    Node node = createNode( name_, parameter_ );
	    oscSender.createNode( node.id, node.type, node.name, node.getParameterArray() );   
	    return node;
    }
	Node createSynth( String name_, String parameterName_, String parameterValue_ ) {
	    Node node = createNode( name_, parameterName_, parameterValue_ );
    	String [] sts = node.getParameterArray();
	    println( sts.length );
	    for( String p : sts ) {
	    	println( p );
	    }
	    oscSender.createNode( node.id, node.type, node.name, node.getParameterArray() );   
	    return node;
    }
	void trigger ( Event event_ ) {
		int id = event_.sourceID;
		Parameters p = event_.parameters;
		String name = p.get("name");
		if ( name == "note_on" || name == "note_off" ) {
			int channel = p.get("channel", 0 );
			int pitch = p.get("pitch", 0 );
			int velocity = p.get("velocity", 0 );
		    println("note_on");
		    println( channel, pitch, velocity );
		}

	}

	// parameters: 

	void setNode( int id_, Parameter parameter_ ) {
		oscSender.setNode( id_, parameter_ );		
	}

}


class OutputController extends SynthController {
	OutputController( int id_ ) {
		super( id_ );
		setType("output");
	}
	
	Node createOutput( int channel_ ) {			
		Node node = createNode( channel_ );
		oscSender.createNode( channel_, node.type, node.name );
		return node;
	}

}