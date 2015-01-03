(

// variables:

~num_o = 30;
~num_b = 30;
~numAudioNodes = 100;
~numControlNodes = 100;
~numOutputs = 2;

o = Array(~num_o);

~audioBusses = Array.newClear( ~num_b );
~audioNodes = Array.newClear( ~numAudioNodes );
~audioOutputs = Array.newClear( ~numOutputs );
~audioRoutes = Dictionary.new();

~controlBusses = Array.newClear( ~num_b );
~controlNodes = Array.newClear( ~numControlNodes );
~controlOutputs = Array.newClear( ~numOutputs );
~controlRoutes = Dictionary.new();


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


~audioNodeTo = {|node1,node2|
	( node1.asString() ++ " ---> " ++ node2.asString() ).postln;
	~audioNodes[ node2 ].set(\inBus, ~audioBusses[ node1 ].index );
	~audioRoutes.put( node1, node2 );
};


~controlNodeOut = {|bus,node|
	( bus.asString() ++ " <--- " ++ node.asString() ).postln;
	~controlNodes[ node ].set(\outBus, ~controlBusses[ bus ].index );
	~controlRoutes.put( node, bus);
	~controlRoutes.postln;
};


~noteOn = {};
~noteOff = {};



// responders:

o.add( OSCresponder(nil, '/createSynth', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var name = msg[3];
	~newSynth.value( index, name );
}).add );
o.add( OSCresponder(nil, '/createBus', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var numChannels = msg[3];
	~newBus.value( type, index, numChannels );
}).add );
o.add( OSCresponder(nil, '/audioNodeTo', {arg time, responder, msg, addr;
	var bus = msg[1];
	var node = msg[2];
	~audioNodeTo.value( bus, node );
}).add );
o.add( OSCresponder(nil, '/controlNodeTo', {arg time, responder, msg, addr;
	var bus = msg[1];
	var node = msg[2];
	~controlNodeIn.value( bus, node );
}).add );





// notas


o.add( OSCresponder(nil, '/noteOn', {arg time, responder, msg, addr;
	~noteOn.value( bus, node );
}).add );

o.add( OSCresponder(nil, '/noteOff', {arg time, responder, msg, addr;
	~noteOff.value( bus, node );
}).add );

)



o.collect{|r| r.remove; };