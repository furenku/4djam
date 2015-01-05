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


~newOutBus = {
	| index, channel |
	~audioBusses[ index ] = channel;
	( "new out bus: " ++ ~audioBusses[index] ++ " for channel: " ++ channel ).postln;
};



~setSynth = {|index, type, key, value|
	if( type == 'Integer' ) { value = value.asInt(); };
	if( type == 'Float' ) {	value = value.asFloat(); };
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
	var offset = 4;
	var parameters;

	if( msg.size() > offset ) {
		var index = offset;
		var parameterIndex = 0;
		var parameterPart;
		parameters = Array.newClear( msg.size() - 4 );
		while( { index < msg.size() }, {

			if( parameterIndex % 2 == 0 ) {
				parameterPart = msg[ index ].asSymbol;
			} {
				parameterPart = msg[ index ].asFloat;
			};

			parameters[ parameterIndex ] = parameterPart;
			index = index + 1;
			parameterIndex = parameterIndex + 1;

		});

	};
	~newSynth.( index, name, parameters );
}).add );
o.add( OSCresponder(nil, '/create_outBus', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var name = msg[3];
	var key = msg[4];
	var channel  = msg[5];
	~newOutBus.( index, channel );
}).add );
o.add( OSCresponder(nil, '/create_bus', {arg time, responder, msg, addr;
	var index = msg[1];
	~newBus.( index );
}).add );




o.add( OSCresponder(nil, '/connect', {arg time, responder, msg, addr;
	var synth = msg[1];
	var bus = msg[2];
	~setSynth.( synth, "Integer", "outBus", bus );
}).add );

o.add( OSCresponder(nil, '/set_node', {arg time, responder, msg, addr;
	var index = msg[1];
	var type = msg[2];
	var key = msg[3];
	var value = msg[4];
	("SET NODE: " ++ index ++ "key: " ++ ' \\' ++ key ++ " : " ++ value ).postln;
	~setSynth.( index, type, key, value );

}).add );


o.add( OSCresponder(nil, '/freeAll', {arg time, responder, msg, addr;
	~synths.collect({|z| if(z!=nil) { z.free; }; });
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