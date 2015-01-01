
class MonoSynth extends EventTarget {
	MonoSynth( int id_ ) {
		super( id_ );
		synth = new Synth("tst");
	}

	Synth synth;
	boolean synthOn = false;

	void createSynth() {
    	synth.create();   
	    synth.set("gate", 0 );
	}

	void freeSynth() {		
	    synth.set("gate", 0 );
	}
    
    void trigger( Event event_ ) {
    	float amp = float( event_.parameters.parameters.get("velocity").value ) / 127;
    	float freq = Frequency.ofMidiNote( int( event_.parameters.parameters.get("pitch").value ) ).asHz();
    	println( "amp " + amp + " freq " + freq );
    	
    	if( event_.parameters.parameters.get("name").value == "note_on" ) {
    		if( ! synthOn ) {    			
			    synth.set("gate", 1 );
			    synth.set("amp", amp );
			    synth.set("freq", freq );
    		} 
    	} else {
    		freeSynth();
    	}

	}
   
}
