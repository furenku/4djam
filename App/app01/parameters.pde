
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
  Parameters() {  
    super( 0 );
    parameters = new HashMap<String,Parameter> ();
  }
  Parameters( int id_ ) {  
    super( id_ );
    parameters = new HashMap<String,Parameter> ();
  }
  Parameters( int id_, String type_, String name_ ) {
    super( id_, type_, name_ );
    parameters = new HashMap<String,Parameter>();
  }
  Parameters( int id_, String type_, String name_, Parameter parameter_ ) {
    super( id_, type_, name_ );
    set( parameter_ );
  }
  Parameters( int id_, String type_, String name_, Parameters parameters_ ) {
    super( id_, type_, name_ );
    parameters = parameters_.parameters;
  }
  Parameters( int id_, String type_, String name_, String parameterName_, String parameterValue_ ) {
    super( id_, type_, name_ );
    parameters = new HashMap<String,Parameter> ();
    set( parameterName_, parameterValue_ );
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
  Parameters set(  Parameters parameters_ ) {
    parameters = parameters_.parameters;
    return this;
  }

  String get( String name_ ) {
    return parameters.get( name_ ).value;
  }
  String get( String name_, String zero_ ) {
    return parameters.get( name_ ).value;
  }
  int get( String name_, int zero_ ) {
    return int( parameters.get( name_ ).value );
  }
  float get( String name_ , float zero_ ) {
    return float( parameters.get( name_ ).value );
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