import wollok.game.*
import personajes.*
import direcciones.*
import elementosJuego.*
import niveles.*

object juego {
	
	method iniciar() {
	self.configurarJuego()
	inicio.configuracionInicial()
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

	method configurarTeclasNiveles() {
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
	
	method image() = "gameover.png"
}

object music1 {
	
	const theme = game.sound("music2.mp3")
	
	method play() {
		theme.volume(0.3)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
}

object hitSound {
		
	method play() {
		game.sound("hit.mp3").play()
	}
}





