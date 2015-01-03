class OscController {
	OscController() {
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



	void createNode( int id_, String type_, String name_ ) {
		if( type_ == "synth" ) {
			OscMessage oscMsg = createMessage( "/createSynth" );
			oscMsg.add( id_ );
			oscMsg.add( type_ );
			oscMsg.add( name_ );
			send( oscMsg );
		}
		if( type_ == "audioBus" || type_ == "controlBus" ) {
			int numChannels = 1;
			OscMessage oscMsg = createMessage( "/createBus" );
			oscMsg.add( id_ );
			oscMsg.add( type_ );
			oscMsg.add( name_ );
			oscMsg.add( numChannels );
			send( oscMsg );
		}
	}


	void route( String type_, int node1_, int node2_ ) {
		OscMessage oscMsg = createMessage( "/"+type_+"NodeTo" );
		oscMsg.add( node2_ );
		oscMsg.add( node2_ );
		send( oscMsg );
	}




}