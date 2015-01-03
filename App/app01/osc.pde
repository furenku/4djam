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

}