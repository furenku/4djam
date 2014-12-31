"TRADUCIR A PROCESSING!!!".postln;

EventNode {
	int id;

	EventNode( int id_ ) {
	}
	init { arg id_;
		id = id_;
	}
	setID { arg id_;
		id = id_;
	}
	getID {
		^id;
	}

}


class EventSource extends EventNode  {

	classvar e;
	classvar source;

	classvar <>target;
	//




	*send { arg event_;
		var message = [ id, event_ ];

		target.trigger( message );

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

EventTarget : EventNode {

	*trigger { arg event;
		("Trigger ID: " + this.id + ", triggers event:").postln;
		event.postln;
	}
}



/*
	Note : Event {

		*send { arg note, vel;

		}
	}
*/





/* MANAGER */

Controller {
	classvar targets;
	*new {
		targets = Dictionary.new();
	}
	*bind {
		arg source_, target_;
		source_.target = this;
		targets.add( source_.id.asSymbol -> target_ );
	}
}

EventController : Controller {



	*trigger { arg message;
		var id = message[0].asSymbol;
		var event = message[1];

		("trigger: " + targets[ id ].id ).postln;
		targets[ id ].trigger( event );
	}
}




Jam4D {

	classvar events;

	*new {
		events = EventController.new();
	}

}


