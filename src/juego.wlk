import wollok.game.*
import personajes.*
import direcciones.*
import elementosJuego.*
import niveles.*

object juego {
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		primerNivel.configuracionInicial()
		game.start()
		
	}

	method configurarJuego() {
		game.title("Juego")
		game.width(25)
		game.height(25)
	}

	method agregarPersonajes() {
		game.addVisualCharacter(personaje)
	}

	method configurarTeclas() {
		keyboard.up().onPressDo({personaje.moverA(arriba)})
		keyboard.right().onPressDo({personaje.moverA(derecha)})
		keyboard.left().onPressDo({personaje.moverA(izquierda)})  
		keyboard.down().onPressDo({personaje.moverA(abajo)}) 
		keyboard.space().onPressDo({personaje.disparar()})
		keyboard.r().onPressDo({personaje.recargarBalas()})
		
	}
	


}

object gameOver {
	
	method position() = game.center()
	
	method image() = "game over.png"
	
	method finalizarJuego(){
		game.schedule(400, {game.clear()})
		game.schedule(500, {juego.iniciar()})
		game.addVisual(self)
	}
}

object music1 {
	
	const theme = game.sound("music2.mp3")
	
	method play() {
		theme.volume(0.1)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
}

object hitSound {
		
	method play() {
		game.sound("hit.mp3").play()
	}
}


