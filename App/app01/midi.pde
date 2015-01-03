/***************	MIDI	***************/

import themidibus.*; //Import the library

MidiBus midiBus;

NoteSource noteSource;
CCSource ccSource;

class NoteSource extends Node {
	NoteSource( int id_ ) {
		super( id_ );
	}


  void send( int onOff_, int channel_, int pitch_, int velocity_ ) {

    String onOff;
    if( onOff_ == 1 )
      onOff = "note_on";
    else
      onOff = "note_off";

    parameters.addParameter( new Parameter("name", onOff ) );  
    parameters.addParameter( new Parameter("channel", channel_ ) );
    parameters.addParameter( new Parameter("pitch", pitch_ ) );
    parameters.addParameter( new Parameter("velocity", velocity_ ) );

    super.send( parameters );

  }


}

class CCSource extends Node {
  CCSource( int id_ ) {
    super( id_ );
  }
  
  void send( int channel_, int number_, int value_ ) {

    parameters.addParameter( new Parameter("channel", channel_ ) );
    parameters.addParameter( new Parameter("number", number_ ) );  
    parameters.addParameter( new Parameter("value", value_ ) );

    super.send( parameters );

  }
}


void setupMIDI() {
	
	midiBus = new MidiBus( this, 0, 1 );

  noteSource = new NoteSource( ctl.nextID() );
  ccSource = new CCSource( ctl.nextID() );


}


void noteOn(int channel, int pitch, int velocity) {
  noteSource.send(1, channel, pitch, velocity );
}

void noteOff(int channel, int pitch, int velocity) {
  noteSource.send(0, channel, pitch, velocity ); 
}

void controllerChange(int channel, int number, int value) {
  ccSource.send( channel, number, value );   
}

