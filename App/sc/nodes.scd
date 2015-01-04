

~newBus.( 'audioBus', 0, 1 );

~audioBusses.collect({|i| if(i!=nil) { i.postln; }; });
~synths.collect({|i| if(i!=nil) { i.postln; }; });

~newSynth.(0,"testGen");
~newOutput.(0);
~newOutput.(1);
~outputs[0][0]


~synths[0].set(\outBus, ~outputs[0][0] );
~synths[0].set(\freq, 2 );
~synths[0].set(\rfreq, 200 );

~synths[1].set(\outBus, ~outputs[0][0] )
~synths[2].set(\outBus, ~outputs[1][0] )
~synths[2].set(\freq, 2 )

b = Bus.audio(s,1);
c = Bus.audio(s,1);

~synths[1].free
~synths[2].set(\outBus,b);
~synths[1].set(\inBus,b);
~synths[1].set(\outBus, 0 );
~synths[1].free
b = ~audioBusses[ 0 ]


x= Synth(\output,[\inBus, b, \outBus, 0 ]);
y= Synth(\testGen,[\outBus, b ]);

SynthDef(\testGen,{ | outBus=99, freq = 0.5, rfreq = 300 |
	var sig = RLPF.ar( WhiteNoise.ar() * Decay2.kr( Impulse.kr( freq ) ), rfreq, 0.1 );
	Out.ar( outBus, sig );
}).store;


SynthDef(\output,{ | inBus=98, outBus=99|
	var in = In.ar( inBus, 1 );
	Out.ar( outBus, in );
}).store;