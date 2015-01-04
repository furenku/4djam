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
	
	Node createBus() {			
		Node node = createNode( type );
		oscSender.createNode( node.id, node.type, node.name );
		return node;
	}
	
}


class OutputController extends OscController {
	OutputController( int id_ ) {
		super( id_ );
		setType("output");
	}
	
	Node createOutput( int channel_ ) {			
		Node node = createNode( channel_, type );
		oscSender.createNode( channel_, node.type, node.name );
		return node;
	}

}



class SynthController extends OscController {
	SynthController( int id_ ) {
		super( id_ );
		setType("synth");
	}
	
	Node createSynth( String name_ ) {			
		Node node = createNode( type, name_ );
		oscSender.createNode( node.id, node.type, node.name );
		return node;
	}


	// parameters: 

	void setNode( int id_, Parameter parameter_ ) {
		oscSender.setNode( id_, parameter_ );		
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


	void createOutput( int channel_ ) {
		outputs.createOutput( channel_);
	}

	void setSender( OscSender oscSender_ ) {
		super.setSender( oscSender_ );
		outputs.setSender( oscSender_ );
		synths.setSender( oscSender_ );
		busses.setSender( oscSender_ );
	}


	

}