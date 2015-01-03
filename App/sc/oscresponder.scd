o = Array(30);
(

//n = NetAddr("127.0.0.1", 57120 );

/*
o.add( OSCresponder(nil, '/test', {arg time, responder, msg, addr;
	msg.postln;
}).add );
*/


o.add( OSCresponder(nil, '/createNode', {arg time, responder, msg, addr;
	var type = msg[1];
	var name = msg[2];

	"create node!".postln;
	"message: ".post;
	msg.postln;

	if( type == 'synth' ) {
		Synth( name.asSymbol() );
	}

}).add );



)

o.collect{|r| r.remove; }


