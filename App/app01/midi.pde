/***************	MIDI	***************/

import themidibus.*; //Import the library



class NoteSource extends EventSource {
	NoteSource( int id_ ) {
		super( id_ );
	}
	void init() {		
	}

}



MidiBus myBus; // The MidiBus
NoteSource noteSource;
void setupMIDI() {
	
	myBus = new MidiBus( this, 0, 1 );

}




void noteOn(int channel, int pitch, int velocity) {
  String[] evt = { "Note On:", "Channel:"+channel, "Pitch:"+pitch, "Velocity:"+velocity  }; 
  NoteSource nSrc = new NoteSource( 103 );
  EventTarget trgt = new EventTarget( 204 );
  nSrc.target = trgt;
  nSrc.send( evt );
}

void noteOff(int channel, int pitch, int velocity) {
  String[] evt = { "Note Off:", "Channel:"+channel, "Pitch:"+pitch, "Velocity:"+velocity  }; 
  NoteSource nSrc = new NoteSource( 103 );
  EventTarget trgt = new EventTarget( 204 );
  nSrc.target = trgt;
  nSrc.send( evt );
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

