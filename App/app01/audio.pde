/*

- create Node

\createNode, "output", "input", inBus
\createNode, "synth", synthName, "output", outBus
\createNode, "synth", synthName, "input", inBus, "output", outBus

noteOn
noteOff

setControl

connect

disconnect

createBus
removeBus




*/

class AudioNode extends Parameters {

	AudioNode( int id_, String name_, String type_ ) {
		setID( id_ );
		setName( name_ );
		setType( type_ );
	}

	int id;

	String type;
	String name;

	void setID( int id_ )  { 
		id = id_;
	}
	int getID() {
		return id;
	}
	void setName( String name_ ){    
		name = name_;
	}
	void setType( String type_ ){    
		type = type_;
	}

}


class AudioController {

	AudioController() {
		nodes 
		= new HashMap<Integer, AudioNode>();
		busses = new HashMap<Integer, AudioNode>();
	}

	HashMap<Integer, AudioNode> nodes;
	HashMap<Integer, AudioNode> busses;

	int lastBusID, lastNodeID;
	OscController oscController;

	int nextNodeID() {
		lastNodeID++;
		return lastNodeID;
	}

	AudioNode createAudioNode( String type_, String name_ ) {
		
		int newID = nextNodeID();
		AudioNode node = new AudioNode( newID, name_, type_ );
		nodes.put( newID, node );
		
		OscMessage oscMsg = oscController.createMessage( "/createAudioNode" );

		oscMsg.add( type_ );
		oscMsg.add( newID );
		oscMsg.add( name_ );

		oscController.send( oscMsg );

		return node;
	}

	AudioNode createBus() {
		
		int newID = nextNodeID();
		String busName = "audioBus_"+newID;;
		String type = "audioBus";
		int numChannels = 1;

		AudioNode node = new AudioNode( newID, "audioBus_"+newID, type );
		busses.put( newID, node );
		
		OscMessage oscMsg = oscController.createMessage( "/createBus" );
		oscMsg.add( type );
		oscMsg.add( newID );
		oscMsg.add( numChannels );
		oscController.send( oscMsg );

		return node;
	}

	void removeNode( int ID_ ) {
		nodes.remove( ID_ );		
	}


	void audioRoute( String route_, int bus_, int node_ ) {
		OscMessage oscMsg = oscController.createMessage( route_ );
		oscMsg.add( bus_ );
		oscMsg.add( node_ );
		oscController.send( oscMsg );
	}

}