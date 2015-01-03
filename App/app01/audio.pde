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



/*

class AudioController extends Node {

	AudioController() {
		nodes = new HashMap<Integer, Node>();
		busses = new HashMap<Integer, Node>();
		super( 1 )
	}

	HashMap<Integer, Node> nodes;
	HashMap<Integer, Node> busses;

	int lastBusID, lastNodeID;
	OscController oscController;



	int nextBusID() {
		lastBusID++;
		return lastBusID;
	}
	int nextNodeID() {
		lastNodeID++;
		return lastNodeID;
	}

	

}

*/