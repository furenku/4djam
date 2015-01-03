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
		nodes = new HashMap<Integer, AudioNode>();
	}

	HashMap<Integer, AudioNode> nodes;
	int lastID;
	OscController oscController;

	int nextID() {
		lastID++;
		return lastID;
	}

	AudioNode createNode( String type_, String name_ ) {
		int newID = nextID();
		AudioNode node = new AudioNode( newID, name_, type_ );
		nodes.put( newID, node );
		
		OscMessage oscMsg = oscController.createMessage();

		oscMsg.add( type_ );
		oscMsg.add( name_ );
		oscMsg.add("freq");
		oscMsg.add(440);
		oscMsg.add("amp");
		oscMsg.add(0.5);

		oscController.send( oscMsg );

		return node;
	}


	void removeNode( int ID_ ) {
		nodes.remove( ID_ );		
	}
}