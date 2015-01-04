
class Node extends Parameters  {  
  Node( int id_ ) {
    super( id_ );
  }
  Node( int id_, String type_, String name_ ) {
    super( id_, type_, name_ );    
  }
  
  NodeController controller;
  
  void setController( NodeController controller_ ) {
    controller = controller_;
  }

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


  Parameter set( Parameter parameter_ ) {
    Parameter parameter = super.set( parameter_ );
    controller.setNode( id, parameter );
    return parameter;
  }
  Parameter set( String name_, String value_ ) {
    Parameter parameter = super.set( name_, value_ );
    controller.setNode( id, parameter );
    return parameter;
  }
  Parameter set( String name_, int value_ ) {
    Parameter parameter = super.set( name_, value_ );    
    controller.setNode( id, parameter );
    return parameter;
  }
  Parameter set( String name_, float value_ ) {
    Parameter parameter = super.set( name_, value_ );    
    controller.setNode( id, parameter );
    return parameter;
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

class NodeController extends Node {

  HashMap< Integer, Node > nodes;
  HashMap< Integer, Routing > routings;
  // OscController oscController;
  int lastID;

  NodeController( int id_ ) {

    super( id_ );
    
    lastID = id_;

    nodes = new HashMap< Integer, Node>();
    routings = new HashMap< Integer, Routing>();

    setType("nodeController");
  }
  

  int nextID() {
    lastID++;
    return lastID;
  }


  void bind( Node source_, Node target_ ) {

    source_.controller = this;

    int id = nextID();
    Routing routing = new Routing( id );

    println( "bind " + source_.id + " to: " + target_.id );

    routing.setSource( source_ );
    routing.setTarget( target_ );

    routings.put( source_.id, routing );

  }


  void dumpRoutings() {
    for (int key_ : routings.keySet()) {
      println( "key " + key_ );
    }

    for ( Routing value_ : routings.values()) {
      println( "routed to " + value_.target.id );
    }
  }


  void trigger( Event event_ ) { 

    int id = event_.sourceID;
    Node target = routings.get( id ).target;

    target.trigger( event_ );

  }



  Node createNode( Node node_ ) {

    int newID = nextID();
    node_.setID( newID );
    node_.controller = this;
    nodes.put( newID, node_ );
    
    return node_;

  }
  Node createNode( int id_, String type_ ) {

    String name = type_ + "_" + id_;
    Node node = new Node( id_, type_, name );
    node.controller = this;
    nodes.put( id_, node );
    
    return node;

  }
  Node createNode( String type_ ) {

    int newID = nextID();
    String name = type_ + "_" + newID;
    Node node = new Node( newID, type_, name );
    node.controller = this;
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( String type_, String name_ ) {

    int newID = nextID();
    Node node = new Node( newID, type_, name_ );
    node.controller = this;
    nodes.put( newID, node );
    
    return node;

  }

  void removeNode( int id_ ) {
    nodes.remove( id_ );    
  }




  // parameters: 

  void setNode( int id_, Parameter parameter_ ) {
    println( "IMPLEMENT CTL -> ADDPARAMETER" );
  }
  

}

