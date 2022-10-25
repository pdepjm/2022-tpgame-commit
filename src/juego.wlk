import wollok.game.*
import personajePrincipal.*
import enemigos.*
import direcciones.*
import elementosJuego.*
import niveles.*

object juego {
	
	method iniciar() {
		self.configurarJuego()
		nivel_0.configuracionInicial()
		game.start()
		
	}

	method configurarJuego() {
		game.title("Juego")
		game.width(12)
		game.height(12)
		game.cellSize(100)
	}

	method agregarPersonajes() {
		game.addVisual(personaje)
		direccion.configurarTeclas()
	}

}

object gameOver {
	
	method position() = game.center()
	method image() = "game over.png"
	method finalizarJuego(){
		
		if (!game.hasVisual(self)) { 
			game.schedule(400, {game.clear()})
			game.addVisual(self) 
			music1.stop() 
		}
			
	}

	method chocasteConJugador(){
		
	}
}

object music1 {
	
	const theme = game.sound("music2.mp3")
	
	method play() {
		theme.volume(0.1)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
	
	method stop() {
		theme.stop()
	}
}

object hitSound {
		
	method play() {
		game.sound("hit.mp3").play()
	}
}


