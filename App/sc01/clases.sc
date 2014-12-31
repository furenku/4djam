
EventSource {

	classvar e;
	classvar source;
	classvar <>id;
	classvar <>target;
	//


	*init {
		"init EventSource class".postln;
	}

	*send { arg event_;
		var message = [ id, event_ ];

		target.trigger( message );

	}

	*new { arg id_;
		id = id_;
		this.init();
	}

}


NoteSource : EventSource {

	*init {
		source = NoteOnResponder({ |src,chan,note,vel|
			var event = [src,chan,note,vel];
			this.send( event );
			},
			nil, // any source
			nil, // any channel
			nil, // any note
			nil // any vel
		);
	}
}

EventTarget {
	*trigger {
	}
}



/*
	Note : Event {

		*send { arg note, vel;

		}
	}
*/





/* MANAGER */

Manager {
	classvar actions;
	*new {
		actions = Dictionary.new();
	}
}

EventManager : Manager {

	*bind {
		arg source_, target_;

		source_.target = this;
		actions.add( source_.id.asSymbol ->
			{ arg event;
				("sent event: "+event).postln;
			}
		);
	}

	*trigger { arg message;
		var id = message[0].asSymbol;
		var event = message[1];

		actions[ id ].value( event );

	}
}




Jam4D {

	classvar events;

	*new {
		events = EventManager.new();
	}

}


