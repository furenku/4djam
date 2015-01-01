/*


SynthDef('tst',{
	| freq=440, amp=0, gate=2 |
	var env = EnvGen.kr( Env.perc(), gate );
	var osc = SinOsc.ar( freq );
	
	var sig = osc * env;
	
	sig = sig * amp;
	
	Out.ar([0,1], sig );
}).store;

*/