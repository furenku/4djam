
class Node extends BaseClass  {  
  Node( int id_ ) {
    super( id_ );
    parameters = new Parameters();
  }
  Node( int id_, String type_, String name_ ) {
    super( id_, type_, name_ );
    parameters = new Parameters();
  }
  
  NodeController controller;
  Parameters parameters;

  Event createEvent( Parameters parameters_ ) {  
    Event event;
    event = new Event();
    event.sourceID = id;
    event.setParameters( parameters_ );    
    return event;    
  }

  void send ( Parameters parameters_ ) {
    controller.trigger( createEvent( parameters_ ) );
  }
  
  void trigger ( Event event_ ) {
    println();
    println( "IMPLEMENT TRIGGER" );
    println("Source ID: " + event_.sourceID + ", triggers target: " + id );
    println( event_.eventStr() );

  }

}





class Routing extends BaseClass {

  Routing( int id_ ) {
    super( id_ );
  }

  Node source;
  Node target;

  void connect( Node source_, Node target_ ) {
    setSource( source_ );
    setTarget( target_ );
  }

  void setSource( Node source_ ) {
    source = source_;
  }
  void setTarget( Node target_ ) {
    target = target_;
  }



}




