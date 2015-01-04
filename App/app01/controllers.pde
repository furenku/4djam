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





class AudioController extends OscController {

	AudioController	( int id_ ) {
		super( id_ );
		setType("audio");
		outputs = new OutputController( id_ );
		synths = new SynthController( id_ );
		busses = new BusController( id_ );
		// controls = new ControlController( id_ );

		synths.setSender( oscSender );
	}

	OutputController outputs;
	SynthController synths;
	BusController busses;
	// ControlController controls;


	Node createOutput( int channel_ ) {
		busses.createBus( channel_ );
		Node output = outputs.createOutput( channel_ );
		output.set( "outBus", channel_ );
		return output;
	}

	void setSender( OscSender oscSender_ ) {
		super.setSender( oscSender_ );
		outputs.setSender( oscSender_ );
		synths.setSender( oscSender_ );
		busses.setSender( oscSender_ );
	}

	

	Routing connect( Node source_, Node target_ ) {
		Routing routing = super.connect( source_, target_ );
		if ( routing.type.equals( "synth-output" ) ) {
			println( routing.type );
			oscSender.connect( routing.source.id, routing.target.id );
		}
		if ( routing.type.equals( "noteSource-synth" ) ) {
			println( routing.type );
			source_.setController( synths );
		}
		return routing;

	}

}