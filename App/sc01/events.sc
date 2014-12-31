
	EventSource {

		var event = [ \the, \symbol, \collection, \contains, \my, \symbol ];

		*send { arg event;
			event.postln;
		}

		*new {
			this.send( event );
		}

	}


	EventTarget {
		*trigger {
		}
	}

	Event { // : Object is implied

		*trigger {

		}

	}

	Note : Event {

		*send { arg note, vel;

		}
	}
	