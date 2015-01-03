KeyboardController keyboard;


void setupKeyboard() {
	keyboard = new KeyboardController();  
}

class KeyboardController {

  void trigger( char _key ) {
    println( _key );
  }
  
};