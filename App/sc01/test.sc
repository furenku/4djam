(
~j  =  Jam4D.new();
~es  =  EventSource.new(117);
~em = EventManager.new();
~em.bind( ~es, "trget" );
~a = 1;

~n = NoteSource.new( 1118 );
~em.bind( ~n, "trget" );

~es.send( [118,~a] );

)
