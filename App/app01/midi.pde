/***************	MIDI	***************/

import themidibus.*; //Import the library

MidiBus midiBus;

NoteSource noteSource;
CCSource ccSource;

class NoteSource extends EventSource {
	NoteSource( int id_ ) {
		super( id_ );
	}


  void trigger( int onOff_, int channel_, int pitch_, int velocity_ ) {

    String onOff;
    if( onOff_ == 1 )
      onOff = "note_on";
    else
      onOff = "note_off";

    parameters.addParameter( new Parameter("name", onOff ) );  
    parameters.addParameter( new Parameter("channel", channel_ ) );
    parameters.addParameter( new Parameter("pitch", pitch_ ) );
    parameters.addParameter( new Parameter("velocity", velocity_ ) );

    super.trigger( parameters );

  }


}



class CCSource extends EventSource {
  CCSource( int id_ ) {
    super( id_ );
  }
  
  void trigger( int channel_, int number_, int value_ ) {

    parameters.addParameter( new Parameter("channel", channel_ ) );
    parameters.addParameter( new Parameter("number", number_ ) );  
    parameters.addParameter( new Parameter("value", value_ ) );

    super.trigger( parameters );

  }
}



void setupMIDI() {
	
	midiBus = new MidiBus( this, 0, 1 );

  noteSource = new NoteSource( ctl.nextID() );
  ccSource = new CCSource( ctl.nextID() );


}




void noteOn(int channel, int pitch, int velocity) {
  noteSource.trigger(1, channel, pitch, velocity );
}

void noteOff(int channel, int pitch, int velocity) {
  noteSource.trigger(0, channel, pitch, velocity ); 
}

void controllerChange(int channel, int number, int value) {
  ccSource.trigger( channel, number, value );   
}

