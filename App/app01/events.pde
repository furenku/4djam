class EventNode {
  int id;

  EventNode( int id_ ) {
    id = id_;
  }
  
  void init() {
  }

  void setID( int id_ )  { 
    id = id_;
  }
  int getID() {
    return id;
  }

}



class EventMessage extends EventNode {
  String [] event;
  
  EventMessage( int id_, String [] event_ ) {
      super( id_ );
      event = event_;
  }

}



class EventTarget extends EventNode {
  EventTarget( int id_ ) {
    super( id_ );
  }
  
  void trigger ( EventMessage message ) {
    println("Source ID: " + message.id + ", triggers target: " + id );
    println( message.event );
  }
}



class EventSource extends EventNode  {
  EventSource( int id_ ) {
    super( id_ );
    id = id_;
    println( "ID: " + id_ );
  }
  
  EventTarget target;
  //


  void send ( String[] event_ ) {
    
    EventMessage message = new EventMessage( id, event_ );
    target.trigger( message );

  }

}


