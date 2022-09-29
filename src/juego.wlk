import wollok.game.*
import personajes.*
import direcciones.*

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
		game.addVisual(zombieFalopa)
	}

	method configurarTeclas() {
		keyboard.w().onPressDo({personaje.moverA(arriba)})
		keyboard.d().onPressDo({personaje.moverA(derecha)})
		keyboard.a().onPressDo({personaje.moverA(izquierda)})  
		keyboard.s().onPressDo({personaje.moverA(abajo)}) 
	}
	
	method configurarAcciones() {
		
		game.onCollideDo(zombieFalopa, {chocado => chocado.perderVida()})
	}
}