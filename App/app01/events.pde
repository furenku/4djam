



class EventMessage extends BaseClass {
  String [] event;
  
  EventMessage( int id_, String [] event_ ) {
      super( id_ );
      event = event_;
  }

}



class EventTarget extends BaseClass {
  
  EventTarget( int id_ ) {
    super( id_ );
  }
  
  void trigger ( EventMessage message ) {
    println();
    println( "IMPLEMENT TRIGGER" );

    println("Source ID: " + message.id + ", triggers target: " + id );
    println( message.event );
  }

}



class EventSource extends BaseClass  {
  EventSource( int id_ ) {
    super( id_ );
    println( "ID: " + id_ );
  }
  
  EventController controller;

  void send ( String[] event_ ) {
    
    EventMessage message = new EventMessage( id, event_ );
    
    controller.trigger( message );

  }

}


