
class Parameter extends BaseClass {
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

  String value;


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

  
  ArrayList<String> getParameterArray() {
    ArrayList<String> parameterArray = new ArrayList<String>();

    for( Parameter p : parameters.values() ) {
      parameterArray.add( p.name );
      parameterArray.add( p.value );
    }

    return parameterArray;
  }

}
