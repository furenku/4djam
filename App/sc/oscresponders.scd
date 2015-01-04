(

// variables:

~num_o = 30;
~num_b = 30;
~numAudioNodes = 100;
~numControlNodes = 100;
~numOutputs = 2;

o = Array(~num_o);

~audioBusses = Array.newClear( ~num_b );
~synths = Array.newClear( ~numAudioNodes );
~audioRoutes = Dictionary.new();
~outputs = Array.newClear( ~numOutputs );
~controlBusses = Array.newClear( ~num_b );
~controlNodes = Array.newClear( ~numControlNodes );
~controlOutputs = Array.newClear( ~numOutputs );
~controlRoutes = Dictionary.new();


// funciones:




~newOutput = {| channel |
	~outputs[channel] = [channel, Synth(\output, [\outBus, channel] ) ];
};

~newSynth = {| index, name, parameters |
	~synths[index] = Synth( name, parameters );
	( "new synth: " ++ ~synths[index] ).postln;
	( "Parameters: " ++ parameters ).postln;
};

~newBus = {
	| index |
	~audioBusses[ index ] = Bus.audio(s, 1);
	( "new bus: " ++ ~audioBusses[index].index ).postln;
};


~synthTo = {|node1,node2|
	( node1.asString() ++ " ---> " ++ node2.asString() ).postln;
	~audioNodes[ node2 ].set(\inBus, ~audioBusses[ node1 ].index );
	~audioRoutes.put( node1, node2 );
};


~setSynth = {|index, type, key, value|

	[ type, value ].postln;
	if( type == 'Integer' ) {
		"integer ".post;
		value = value.asInt();
	};
	if( type == 'Float' ) {
		"float ".post;
		value = value.asFloat();
	};

	value.postln;


	~synths[ index ].set( key.asSymbol(), value );
};

// responders:

/*
o.add( OSCresponder(nil, '/createOscNode', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var name = msg[3];
}).add );
*/


o.add( OSCresponder(nil, '/test_message', {arg time, responder, msg, addr;
	msg.postln;
	msg.size.postln;
}).add );




o.add( OSCresponder(nil, '/create_output', {arg time, responder, msg, addr;
	var index = msg[1];
	~newOutput.( index );
}).add );
o.add( OSCresponder(nil, '/create_synth', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var name = msg[3];
	~newSynth.( index, name );
}).add );
o.add( OSCresponder(nil, '/create_bus', {arg time, responder, msg, addr;
	var index = msg[1];
	~newBus.( index );
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



o.add( OSCresponder(nil, '/set_node', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var key = msg[3];
	var value = msg[4];
	("SET NODE: " ++ index ++' \\'++ "key: " ++ key ++ " : " ++ value ).postln;
	~setSynth.( index, type, key, value );

}).add );


// notas

/*
o.add( OSCresponder(nil, '/noteOn', {arg time, responder, msg, addr;
	~noteOn.value( bus, node );
}).add );

o.add( OSCresponder(nil, '/noteOff', {arg time, responder, msg, addr;
	~noteOff.value( bus, node );
}).add );

*/

)



o.collect{|r| r.remove; };