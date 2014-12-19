// =====================================================================
// escombro FX!
// =====================================================================

s.boot

().play

b = (buss: Bus.audio(s, 2));


(
SynthDef(\in, {
	
	arg bus=0,
	preamp=1,
	dist=1/2,
	thrshld=0.5,
	slpBlw=1,
	slpAbv=1,
	clmpTm=0.005,
	rlxTm=0.15,
	lofreq = 80, midfreq = 800, hifreq = 5000,
	//	band1 = -45, band2 = -45, band3 = -45,
	lo=3,mid=1,hi=3;

	z = AudioIn.ar(1) * preamp;


	// dist

	z = z.tanh;//wrap2(dist);


	// comp
	z = Compander.ar( z, z, thrshld,slpBlw, slpAbv, clmpTm, rlxTm );

	// eq
	z = BPeakEQ.ar(z, lofreq, 1, lo);
    z = BPeakEQ.ar(z, midfreq,1, mid);
    z = BPeakEQ.ar(z, hifreq, 1, hi);

	// reverb
	z = FreeVerb.ar( z, 1/2, 1/2, 1/2, 1/2 );

	// limiter
	z = Limiter.ar( z );

	// pan & out
	Out.ar(bus,Pan2.ar(z));

}).store;


z = Synth(\in);
//d = Synth(\bbdDelay).play;


z.set(\bus,b.buss);
z.set(\preamp,12);
z.set(\lo,24);
z.set(\mid,2);
z.set(\hi,22);

// BBD block with low pass filtering
~bbdBlock = { |input, sampleRate=4000, msLength=10|
    var numSamples = ((SampleRate.ir / 1000) * msLength).floor;
    var buf = LocalBuf(numSamples * 2, input.numChannels).clear;

    var clk = Impulse.ar(sampleRate);
    var count = PulseCount.ar(clk);

    var readpos = count % (numSamples * 2);
    var writepos = (numSamples + count) % (numSamples * 2);
    var write, read;
    
    var lpf = (sampleRate / 8).max(400).min(18000);
    input = LPF.ar(input, lpf);
    
    write = BufWr.ar(input, buf, writepos);
    read = BufRd.ar(input.numChannels, buf, readpos);
    
    LPF.ar(read, lpf);
};

Ndef(\bbdDelay, {|dlyTm=62.5,fdbck=0.5,smplRt=15000,mix=0.5|


    
    var input = In.ar(b.buss, b.buss.numChannels);
    var local = LocalIn.ar(input.numChannels);
    var signal = local * fdbck;

    // 62.5 is delay buffer length in ms
    signal = ~bbdBlock.value(input + signal, smplRt, dlyTm);
    LocalOut.ar(signal);
    
    XFade2.ar(input, signal, mix);
}).play;


Ndef(\bbdDelay).set(\dlyTm,100);
Ndef(\bbdDelay).set(\fdbck,1/2);
Ndef(\bbdDelay).set(\smpltRt,200);
Ndef(\bbdDelay).set(\smpltRt,6000);
Ndef(\bbdDelay).set(\smpltRt,12220);

)


(
c = CCResponder({ |src,chan,num,value|
[src,chan,num,value].postln;

switch(num,
0, {
	Ndef(\bbdDelay).set(\dlyTm,value);
},
1, {
	Ndef(\bbdDelay).set(\fdbck,value/127);
},
2, {
	(2).postln;
});


},
nil, // any source
nil, // any channel
nil, // any CC number
nil // any value
)
)


c.remove;
