class BaseClass {
  
  int id;
  String type;
  String name;

  BaseClass() {
    setID( 0 );
    setType( "undefined" );    
    setName( "undefined" );
    
  }
  BaseClass( int id_ ) {
    setID( id_ );
    setType( "undefined" );    
    setName( "undefined" );
  }
  BaseClass( int id_, String type_ ) {
    setID( id_ );
    setType( type_ );
    setName( "undefined" );
  }
  BaseClass( int id_, String type_, String name_ ) {
    setID( id_ );
    setType( type_ );
    setName( name_ );
  }

  void init() {
  }

  void setID( int id_ )  { 
    id = id_;
  }
  int getID() {
    return id;
  }

  void setName( String name_ )  { 
    name = name_;
  }
  String getName() {
    return name;
  }


  void setType( String type_ )  { 
    type = type_;
  }
  String getType() {
    return type;
  }




}