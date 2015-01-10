(


)


(
~j  =  Jam4D.new();
~ec = EventController.new();
//~ec.id = 1;

~es  =  EventSource.new();

~n = NoteSource.new( 1118 );

~trgt1 = EventTarget.new( 201 );
~trgt2 = EventTarget.new( 212 );

"show ids: ".postln;

~trgt1.getID().postln;
~trgt2.getID().postln;

//~ec.bind( ~es, ~trgt1 );
//~ec.bind( ~n, ~trgt2 );

/*
~a = 1;
~es.send( [118,~a] );
*/
)
