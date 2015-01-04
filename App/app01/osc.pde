class OscSender {
	OscSender() {
		receiveAtPort = 12000;
		sendToPort = 57120;
		host = "127.0.0.1";
		oscP5event = "oscP5event";
		oscP5 = new OscP5(this, host, sendToPort, receiveAtPort, oscP5event);		
	}

	OscP5 oscP5;
	int sendToPort;
	int receiveAtPort;
	String host;
	String oscP5event;


	OscMessage createMessage( String address_ ){
		OscMessage oscMsg = oscP5.newMsg( address_ );
		return oscMsg;
	}

	void send( OscMessage oscMsg_ ) {
		oscP5.send( oscMsg_ );
	}



	void createNode( int id_, String type_ ) {
		OscMessage oscMsg = createMessage( "/create_" + type_ );
		oscMsg.add( id_ );
		oscMsg.add( type_ );
		send( oscMsg );
	}
	void createNode( int id_, String type_, String name_ ) {
		OscMessage oscMsg = createMessage( "/create_" + type_ );
		oscMsg.add( id_ );
		oscMsg.add( type_ );
		oscMsg.add( name_ );
		send( oscMsg );
	}
	void createNode( int id_, String type_, String name_, String [] parameters_ ) {
		OscMessage oscMsg = createMessage( "/create_" + type_ );
		oscMsg.add( id_ );
		oscMsg.add( type_ );
		oscMsg.add( name_ );
		oscMsg.add( parameters_ );
		send( oscMsg );
	
	}


	void route( String route_, int node1_, int node2_ ) {
		OscMessage oscMsg = createMessage( "/"+route_+"NodeTo" );
		oscMsg.add( node2_ );
		oscMsg.add( node2_ );
		send( oscMsg );
	}




/*
	void setSynth( Node node_ ) {
	}
*/
	void setNode( int id_, Parameter parameter_ ) {		
		OscMessage oscMsg = createMessage( "/set_node" );
		oscMsg.add( id_ );
		oscMsg.add( parameter_.type );
		oscMsg.add( parameter_.name );
		oscMsg.add( parameter_.value );
		send( oscMsg );	
	}
	void setNode( int id_, Parameters parameters_ ) {		
		OscMessage oscMsg = createMessage( "/set_node" );
		oscMsg.add( id_ );
		oscMsg.add( parameters_.getParameterArray() );
		send( oscMsg );	
	}
	
}