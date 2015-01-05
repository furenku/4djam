
class Node extends Parameters  {  
  Node( int id_ ) {
    super( id_ );
  }
  Node( int id_, String type_, String name_ ) {
    super( id_, type_, name_ );    
  }
  Node( int id_, String type_, String name_, Parameters parameters_ ) {
    super( id_, type_, name_, parameters_ );    
  }

  NodeController controller;
  
  void setController( NodeController controller_ ) {
    controller = controller_;

    println( "set Controller type: " + controller_.type + " to node type " + type );
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






  Node createNode() {

    int newID = nextID();
    String name = type + "_" + newID;
    Node node = new Node( newID, type, name );
    node.setController( this );
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( int id_ ) {

    String name = type  + "_" + id_;
    Node node = new Node( id_, type, name );
    node.setController( this );
    nodes.put( id_, node );
    
    return node;

  }
  Node createNode( String name_ ) {

    int newID = nextID();
    Node node = new Node( newID, type, name_ );
    node.setController( this );
    nodes.put( newID, node );
    
    return node;

  }

  Node createNode( Parameter parameter_ ) {

    int newID = nextID();
    String name = type + "_" + newID;
    Node node = new Node( newID, type, name );
    node.setController( this );
    node.set( parameter_ );
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( Parameters parameters_ ) {

    int newID = nextID();
    String name = type + "_" + newID;
    Node node = new Node( newID, type, name, parameters_ );
    node.setController( this );
    
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( String name_, Parameter parameter_ ) {

    int newID = nextID();
    String name = name_;
    Node node = new Node( newID, type, name );
    node.setController( this );
    node.set( parameter_ );
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( String name_, String parameterName_, String parameterValue_ ) {

    int newID = nextID();
    String name = name_;

    Node node = new Node( newID, type, name );
    node.setController( this );
    node.set( parameterName_, parameterValue_ );
    nodes.put( newID, node );
    
    return node;

  }
  Node createNode( String name_, Parameters parameters_ ) {

    int newID = nextID();
    Node node = new Node( newID, type, name_, parameters_ );
    node.setController( this );
    nodes.put( newID, node );
    
    return node;

  }



  void removeNode( int id_ ) {
    nodes.remove( id_ );    
  }




  void trigger( Event event_ ) { 

    int id = event_.sourceID;
    Node target = routings.get( id ).target;

    target.trigger( event_ );

  }



  // parameters: 

  void setNode( int id_, Parameter parameter_ ) {
    println( "IMPLEMENT CTL -> ADDPARAMETER" );
  }

  Routing connect( Node source_, Node target_ ) {

    int id = nextID();
    Routing routing = new Routing( id );
    routing.setType( source_.type + "-" + target_.type );
    routing.setSource( source_ );
    routing.setTarget( target_ );

    routings.put( source_.id, routing );

    source_.setController( this );

    return routing;

  }
  
  void dumpRoutings() {
    for (int key_ : routings.keySet()) {
      println( "key " + key_ );
    }

    for ( Routing value_ : routings.values()) {
      println( "routed to " + value_.target.id );
    }
  }
  

}

