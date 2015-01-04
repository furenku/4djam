
/*class MonoSynth extends Node {
	MonoSynth( int id_ ) {
		super( id_ );
		synth = new Synth("monoSynth");
	}

	Synth synth;
	boolean synthOn = false;

	void createSynth() {
    	synth.create();   
	}

	void freeSynth() {		
	    synth.set("t_trig", 0 );
	}
    
    void trigger( Event event_ ) {
    	float amp = float( event_.parameters.parameters.get("velocity").value ) / 127;
    	float freq = Frequency.ofMidiNote( int( event_.parameters.parameters.get("pitch").value ) ).asHz();
    	println( "amp " + amp + " freq " + freq );
    	
    	if( event_.parameters.parameters.get("name").value == "note_on" ) {
    		if( ! synthOn ) {    			
			    synth.set("t_trig", 1 );
			    synth.set("amp", amp );
			    synth.set("freq", freq );
    		} 
    	} else {
    		freeSynth();
    	}

	}
   
}




class PolySynth extends Node {
	PolySynth( int id_ ) {
		super( id_ );
		synth = new Synth("polySynth");
	}

	Synth synth;
	boolean synthOn = false;

	void createSynth() {
    	synth.create();   
	    synth.set("t_trig", 0 );
	}

	void addSynth() {
    	synth.create();   
	    synth.set("t_trig", 0 );
	}

	void freeSynth() {		
	    synth.set("t_trig", 0 );
	}
    
    void trigger( Event event_ ) {
    	float amp = float( event_.parameters.parameters.get("velocity").value ) / 127;
    	float freq = Frequency.ofMidiNote( int( event_.parameters.parameters.get("pitch").value ) ).asHz();
    	println( "amp " + amp + " freq " + freq );
    	
    	if( event_.parameters.parameters.get("name").value == "note_on" ) {
    		if( ! synthOn ) {    			
			    synth.set("t_trig", 1 );
			    synth.set("amp", amp );
			    synth.set("freq", freq );
    		} 
    	} else {
    		freeSynth();
    	}

	}
   
}
*/