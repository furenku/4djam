
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

  Parameter( String name_, float value_ ) {
    setName( name_ );
    setType( "Float" );
    setValue( str( value_ ) );
  }
  String value;


  void setValue( String value_ ) {
    value = value_;
  }
  

}




class Parameters extends BaseClass {

  Parameters( int id_ ) {  
    super( id_ );
    parameters = new HashMap<String,Parameter> ();
  }
  Parameters( int id_, String type_, String name_ ) {
    super( id_, type_, name_ );
    parameters = new HashMap<String,Parameter>();
  }

  HashMap<String,Parameter> parameters;

  Parameter set( Parameter parameter_ ) {
    Parameter parameter = new Parameter( parameter_.name, parameter_.value );
    parameters.put( parameter_.name, parameter );
    return parameter;

  }
  Parameter set( String name_, String value_ ) {
    Parameter parameter = new Parameter( name_, value_ );
    parameters.put( name_, parameter );
    return parameter;
  }
  Parameter set( String name_, int value_ ) {
    Parameter parameter = new Parameter( name_, value_ );
    parameters.put( name_, parameter );
    return parameter;
  }
  Parameter set( String name_, float value_ ) {
    Parameter parameter = new Parameter( name_, value_ );
    parameters.put( name_, parameter );
    return parameter;
  }

  
  String [] getParameterArray() {
    ArrayList<String> parameterList = new ArrayList<String>();
    String [] parameterArray;
    for( Parameter p : parameters.values() ) {
      parameterList.add( p.name );
      parameterList.add( p.value );
    }

    parameterArray = new String [ parameterList.size() ];

    for( int i = 0; i < parameterList.size(); i++  ) {
      parameterArray[i] = parameterList.get( i );
      println( parameterArray[ i ] );

    }

    return parameterArray;
  }

}


class RangeParameter extends Parameter {
  RangeParameter() {
    name = "undefined";
    type = "undefined";
    value = str(0);
  }
}