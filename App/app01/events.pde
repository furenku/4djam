

class Event {

  Event() {

  }

  int sourceID;
  Parameters parameters;

  void addParameter( Parameter parameter_ ) {
    parameters.addParameter( parameter_ );
  }


  void setSourceID( int id_ ) {
    sourceID = id_;
  }

  void setParameters( Parameters parameters_ ) {
    parameters = parameters_;
  }

  String eventStr() {
    String _str;
    _str = "";
    

    for ( Parameter p  : parameters.parameters.values() ) {
      _str += p.name + ": " + p.value + "\n";      
    }
    
    return _str;
  }
  

}




class EventTarget extends BaseClass {
  
  EventTarget( int id_ ) {
    super( id_ );
  }
  
  void trigger ( Event event_ ) {
    println();
    println( "IMPLEMENT TRIGGER" );

    println("Source ID: " + event_.sourceID + ", triggers target: " + id );
    println( event_.eventStr() );

  }

}



class EventSource extends BaseClass  {
  
  EventSource( int id_ ) {
    super( id_ );
    parameters = new Parameters();
  }
  
  EventController controller;
  Parameters parameters;

  Event createEvent( Parameters parameters_ ) {
    
    Event event;

    event = new Event();

    event.sourceID = id;
    event.setParameters( parameters_ );
    
    return event;    
  }

  void send ( Event event_ ) {
   
    controller.trigger( event_ );

  }


  void trigger( Parameters parameters_ ) {
    send( createEvent( parameters_ ) );
  }

}


