

~newBus.( 'audioBus', 0, 1 );

~audioBusses.collect({|i| if(i!=nil) { i.postln; }; });
~synths.collect,({|i| if(i!=nil) { i.postln; }; });

~outputs[0][0]


~newSynth.(1,"output");
~newSynth.(0,"testGen");

~synths[0].set(\outBus, b );
~synths[1].set(\inBus, b );
~synths[1].set(\outBus, 0 );

~setSynth.(1,"Float","freq","0.5")

~synths[0].set(\freq, 2 );
~synths[0].set(\rfreq, 200 );

~synths[1].set(\outBus, ~outputs[0][0] )
~synths[2].set(\outBus, ~outputs[1][0] )
~synths[2].set(\freq, 1/2 )

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


SynthDef(\testNote,{ | outBus=99, freq = 300, t_trig = 0 |
	var sig = RLPF.ar( WhiteNoise.ar() * EnvGen.kr(Env.perc, t_trig), freq, 0.1 );
	Out.ar( outBus, sig );
}).store;

SynthDef(\polyNoteEnv,{ | outBus=99, pitch = 72, velocity = 127, t_trig = 1 |
	var amp = velocity / 127;
	var sig = RLPF.ar( WhiteNoise.ar() * EnvGen.kr(Env.perc, t_trig, doneAction: 2), pitch.midicps, 0.1 );
	Out.ar( outBus, sig * amp );
}).store;

SynthDef(\polyNote,{ | outBus=99, pitch = 72, velocity = 0, t_trig = 0 |
	var amp = velocity / 127;
	var sig = RLPF.ar( WhiteNoise.ar(), pitch.midicps, 0.1 );
	Out.ar( outBus, sig * amp );
}).store;


n = Synth(\testNote)

n.set(\outBus, 0)
n.set(\t_trig,1)
n.set(\freq,140)