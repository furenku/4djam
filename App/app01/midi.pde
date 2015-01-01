/***************	MIDI	***************/

import themidibus.*; //Import the library


NoteSource noteSource;

class NoteSource extends EventSource {
	NoteSource( int id_ ) {
		super( id_ );
	}
	void init() {		
	}

}



MidiBus myBus;


void setupMIDI() {
	
	myBus = new MidiBus( this, 0, 1 );

  noteSource = new NoteSource( 101 );

}




void noteOn(int channel, int pitch, int velocity) {
  String[] evt = { "Note On:", "Channel:"+channel, "Pitch:"+pitch, "Velocity:"+velocity  }; 
  noteSource.send( evt );
}

void noteOff(int channel, int pitch, int velocity) {
  String[] evt = { "Note Off:", "Channel:"+channel, "Pitch:"+pitch, "Velocity:"+velocity  }; 
  noteSource.send( evt );
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

