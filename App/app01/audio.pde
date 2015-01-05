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
			oscSender.connect( routing.source.id, routing.target.id );
		}
		if ( routing.type.equals( "noteSource-synth" ) ) {
			source_.setController( synths );
		}
		return routing;

	}

}