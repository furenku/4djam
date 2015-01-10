class Event extends Parameters {

  Event() {
    super();
  }

  int sourceID;
  
  void setSourceID( int id_ ) {
    sourceID = id_;
  }
  int getSourceID() {
    return sourceID;
  }
  String eventStr() {
    String _str;
    _str = "";
    

    for ( Parameter p  : parameters.values() ) {
      _str += p.name + ": " + p.value + "\n";      
    }
    
    return _str;
  }
  

}