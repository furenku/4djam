
class Parameter {
  Parameter() {
    name = "undefined";
    type = "undefined";
    value = str(0);
  }
  
  Parameter( String name_, String value_ ) {
    setName( name_ );
    setType( "String" );
    setValue( value_ );
  }

  Parameter( String name_, int value_ ) {
    setName( name_ );
    setType( "Integer" );
    setValue( str( value_ ) );
  }

  String type;
  String name;
  String value;

  void setName( String name_ ){    
    name = name_;
  }
  void setType( String type_ ){    
    type = type_;
  }
  void setValue( String value_ ) {
    value = value_;
  }
  

}




class Parameters {

  Parameters() {
    parameters = new HashMap<String,Parameter> ();
  }

  HashMap<String,Parameter> parameters;

  void addParameter( Parameter parameter_ ) {
    parameters.put( parameter_.name, parameter_ );
  }

}
