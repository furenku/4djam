b = Bus.audio(s,1);


~newBus.value( "audioBus", 10, 1 );

~audioBuffers.collect({|bf| if(bf) { bf.postln; }; });

b = ~audioBuffers[ 10 ]


x= Synth(\output,[\inBus, b.index, \outBus, 0 ]);
y= Synth(\testGen,[\outBus, b.index ]);

SynthDef(\testGen,{ | outBus |
	var sig = WhiteNoise.ar() * Decay2.kr( Impulse.kr(1/2) );
	Out.ar( outBus, sig );
}).store;


SynthDef(\output,{ | inBus, outBus |

	var in = In.ar( inBus, 1 );

	Out.ar( outBus, in );
}).store;