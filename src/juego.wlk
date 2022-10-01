import wollok.game.*
import personajes.*
import direcciones.*
import elementosJuego.*

object juego {
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones()
		game.start()
	}

	method configurarJuego() {
		game.title("Juego")
		game.width(25)
		game.height(25)
		game.boardGround("grass00.png")
		
	}

	method agregarPersonajes() {
		game.addVisualCharacter(personaje)
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
		game.addVisual(corazon4)
		game.addVisual(corazon5)
		game.addVisual(zombie1)
	}

	method configurarTeclas() {
		keyboard.up().onPressDo({personaje.moverA(arriba)})
		keyboard.right().onPressDo({personaje.moverA(derecha)})
		keyboard.left().onPressDo({personaje.moverA(izquierda)})  
		keyboard.down().onPressDo({personaje.moverA(abajo)}) 
		//keyborard.space().onPressDo({personaje.disparar())
	}
	
	method configurarAcciones() {
		game.onTick(5000, "Movimiento Zombie", {zombie1.moverse()})
		game.onCollideDo(zombie1, {chocado => chocado.perderVida()})
	}

}

object fin {
	
	method position() = game.center()
	
	method image() = "gameover.png"
}

object music1 {
	
	method reproducir {
		const music = game.sound("music1.mp3")
		music.shouldLoop(true)
		game.schedule(100, {music.play()})
		
	}
}




