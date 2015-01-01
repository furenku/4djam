/***************	MIDI	***************/

import themidibus.*; //Import the library


NoteSource noteSource;

class NoteSource extends EventSource {
	NoteSource( int id_ ) {
		super( id_ );
	}
	void init() {		
	}

  Parameters note;

}



MidiBus myBus;


void setupMIDI() {
	
	myBus = new MidiBus( this, 0, 1 );

  noteSource = new NoteSource( ctl.nextID() );

}


void note( int onOff_, int channel_, int pitch_, int velocity_ ) {

  String onOff;
  if( onOff_ == 1 )
    onOff = "note_on";
  else
    onOff = "note_off";


  Parameters parameters = new Parameters();
  Parameter parameter;

  parameter = new Parameter("name", onOff );
  parameters.addParameter( parameter );
  
  parameter = new Parameter("channel", channel_ );
  parameters.addParameter( parameter );
  
  parameter = new Parameter("pitch", pitch_ );
  parameters.addParameter( parameter );

  parameter = new Parameter("velocity", velocity_ );
  parameters.addParameter( parameter );

  noteSource.trigger( parameters );

}

void noteOn(int channel, int pitch, int velocity) {
  note(1, channel, pitch, velocity );
}

void noteOff(int channel, int pitch, int velocity) {
 note(0, channel, pitch, velocity ); 
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

