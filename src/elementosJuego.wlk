  import wollok.game.*
 import juego.*
 import personajes.*
 
 
class Corazon {
    const property position
    
	method image() = "corazon4.png"
	
	method agregarse(){
		game.addVisual(self)
	}
}

class Proyectil {

    var property position = personaje.position()

    method image() = "bolaFuego.png"

    method mover() {
		position = game.at(position.x()+1, position.y())
    }
   
    method trayectoria() {
    	game.onTick(100, "Movimiento proyectil",{self.mover()})
    }
    
    method chocasteConEnemigo(elEnemigo) {
    	
    	elEnemigo.disminuirVida()
    	game.removeVisual(self)
    	
    }
    
    method chocasteConJugador() {
    	
    }
	
}

object imagenDelContador {
	const property position = game.at(23, 23)
	
	method image() = "bolaFuego.png"
	
	method agregarse(){
		game.addVisual(self)
	}
	
}

object contadorDeBalas {
	const property position = game.at(22, 23)
	
	method text() = "Bolas:" + (personaje.bolasDeFuego().size()).toString()
	
	method agregarse(){
		game.addVisual(self)
	}
}

object curita {
	
	var property position = game.center() 
	
	method image() = "vendajeChico.png"
	
	method agregarse() {
		
		
		game.schedule(5000,{=> game.addVisual(self)})
		
		
		}
		
	method chocasteConEnemigo(unEnemigo) {
		
	}
	
	method chocasteConJugador() {
		personaje.aumentarTodaLaVida() 
		game.removeVisual(self)
	}

	
}

object relojDeArena {
	
	var property position = game.at(5,5)
	
	method image() = "relojArena.png"
	
	method chocasteConJugador() {
		
		keyboard.r().onPressDo({personaje.recargarBalas(4500)})
		game.schedule(12500,{keyboard.r().onPressDo({personaje.recargarBalas()})})
		
	}
	
	method agregarse() {
		
		
		game.schedule(5000,{=> game.addVisual(self)})
		
		
	}
}


const unProyectil = new Proyectil() 
