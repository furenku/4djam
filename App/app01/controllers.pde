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
		channels = new HashMap<Integer, Node>();
	}
	HashMap<Integer, Node> channels;

	
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
	    oscSender.createNode( node.id, node.type, node.name, node.getParameterArray() );   
	    return node;
    }
    Node createSynth( String name_, Parameters parameters_ ) {
	    Node node = createNode( name_, parameters_ );
    	oscSender.createNode( node.id, node.type, node.name, parameters_.getParameterArray() );   
	    return node;
    }
    Node createSynth( int id_, String name_, String parameterName_, String parameterValue_ ) {
	    Node node = createNode( id_, name_, parameterName_, parameterValue_ );
    	String [] sts = node.getParameterArray();
	    oscSender.createNode( node.id, node.type, node.name, node.getParameterArray() );   
	    return node;
    }
    Node createSynth( int id_, String name_, Parameters parameters_ ) {
    	Node node = createNode( id_, name_, parameters_ );
		oscSender.createNode( node.id, node.type, node.name, parameters_.getParameterArray() );
		return node;
	}



	void trigger ( Event event_ ) {
		int id = event_.sourceID;
		String name = event_.getName();
		println( "trigger " + name );
		if ( name.equals("note_on") ) {
			polyNoteOn( event_ );
		}
		if ( name.equals("note_off") ) {
			polyNoteOff( event_ );
		}

	}


	void assignChannel( int channel_, Node node_ ) {
		channels.put( channel_, node_ );
	}


	void setPolyMode( Node node_ ){
		node_.initController("synth");
	}
	void polyNoteOn( Event event_ ) {

		int channel = event_.get("channel", 0 );
		int pitch = event_.get("pitch", 0 );
		int velocity = event_.get("velocity", 0 );


		Parameters p  = new Parameters();

		p.set( "pitch", pitch );
		p.set( "velocity", velocity );
		p.set( "t_trig", 1 );
		p.set( "outBus", 0 );

		// nodes.get( event_.getSourceID() ).set( p ); 
	    
	    println("note_on");
	    println( channel, pitch, velocity );
	    
	    Node synth = channels.get( channel );
	    synth.initController( type );
	    
	    Node noteNode = synth.nodeController.createNode( pitch, "polyNote", p );
	    oscSender.createNode( pitch, noteNode.type, noteNode.name, noteNode.getParameterArray() );

	}

	void polyNoteOff( Event event_ ) {

		int channel = event_.get("channel", 0 );
		int pitch = event_.get("pitch", 0 );
		int velocity = event_.get("velocity", 0 );

	    println("note_off");
	    println( channel, pitch, velocity );
	    
	    // Node synth = channels.get( channel );
	    // synth.nodeController.removeNode( pitch );
	    oscSender.freeNode( pitch );

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