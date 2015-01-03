o = Array(30);
(

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


