(

// variables:

~num_o = 30;
~num_b = 30;
~numAudioNodes = 100;
~numOutputs = 2;

o = Array(~num_o);
~audioBusses = Array.newClear( ~num_b );
~controlBusses = Array.newClear( ~num_b );
~audioNodes = Array.newClear( ~numAudioNodes );

~audioOutputs = Array.newClear( ~numOutputs );




// funciones:

~newAudioNode = {
	| index, name |
	~audioNodes[index] = Synth( name );
};



~newBus = {
	| type, index, numChannels |
	[ type, index, numChannels ].postln;
	if( type == 'audioBus' ) {
		~audioBusses[index] = Bus.audio(s,numChannels);
		( "new audio bus: " ++ ~audioBusses[index].index ).postln;
	};
	if( type == "controlBus" ) {
		~controlBusses[index] = Bus.control(s,numChannels);
	};
};


~nodeIn = {|bus,node|
	( bus.asString() ++ " ---> " ++ node.asString() ).postln;
	~audioNodes[ node ].set(\inBus, ~audioBusses[ bus ].index );
};

~nodeOut = {|bus,node|
	( bus.asString() ++ " <--- " ++ node.asString() ).postln;
	~audioNodes[ node ].set(\outBus, ~audioBusses[ bus ].index );
};



// responders:

o.add( OSCresponder(nil, '/createAudioNode', {arg time, responder, msg, addr;
	var type = msg[1];
	var index = msg[2];
	var name = msg[3];

	"create node!".postln;
	"message: ".post;
	msg.postln;

	~newAudioNode.value( index, name );
	/*
	if( type == 'synth' ) {
		~newSynth.value( name );
	}
	if( type == 'output' ) {
		~newOutput.value();
	}
	*/
}).add );



o.add( OSCresponder(nil, '/createBus', {arg time, responder, msg, addr;
	var type = msg[1];
	var index = msg[2];
	var numChannels = msg[3];

	"create bus!".postln;
	"message: ".post;
	msg.postln;


	~newBus.value( type, index, numChannels );

}).add );



o.add( OSCresponder(nil, '/nodeIn', {arg time, responder, msg, addr;
	var bus = msg[1];
	var node = msg[2];

	( "audio from bus: " ++ bus ++ " to node:  " ++ node ).postln;

	~nodeIn.value( bus, node );

}).add );

o.add( OSCresponder(nil, '/nodeOut', {arg time, responder, msg, addr;
	var bus = msg[1];
	var node = msg[2];

	( "audio to bus: " ++ bus ++ " from node " ++ node ).postln;

	~nodeOut.value( bus, node );

}).add );

)

o.collect{|r| r.remove; }


