/***************	MIDI	***************/

import themidibus.*; //Import the library

MidiBus midiBus;

NoteSource noteSource;
CCSource ccSource;

class NoteSource extends Node {

	NoteSource( int id_ ) {
		super( id_ );
    setType( "noteSource" );
	}


  void send( int onOff_, int channel_, int pitch_, int velocity_ ) {

    String onOff;
    if( onOff_ == 1 )
      onOff = "note_on";
    else
      onOff = "note_off";

    set( "name", onOff );  
    set( "channel", channel_ );
    set( "pitch", pitch_ );
    set( "velocity", velocity_ );

    super.send( this );

  }


}

class CCSource extends Node {
  CCSource( int id_ ) {
    super( id_ );
  }
  
  void send( int channel_, int number_, int value_ ) {

    set( "channel", channel_ );
    set( "number", number_ );  
    set( "value", value_ );

    super.send( this );

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

