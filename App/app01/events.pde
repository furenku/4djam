class Event {

  Event() {

  }

  int sourceID;
  Parameters parameters;

  void addParameter( Parameter parameter_ ) {
    parameters.set( parameter_ );
  }


  void setSourceID( int id_ ) {
    sourceID = id_;
  }

  void setParameters( Parameters parameters_ ) {
    parameters = parameters_;
  }

  String eventStr() {
    String _str;
    _str = "";
    

    for ( Parameter p  : parameters.parameters.values() ) {
      _str += p.name + ": " + p.value + "\n";      
    }
    
    return _str;
  }
  

}