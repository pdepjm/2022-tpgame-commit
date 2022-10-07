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
    
    method agregarse(){
		game.addVisual(self)
	}

    method mover() {
		position = game.at(position.x()+1, position.y())
    }
   
    method trayectoria() {
    	game.onTick(100, "Movimiento proyectil",{self.mover()})
    }
    
    method hacerDanio(enemigo) {
    	enemigo.disminuirVida()
      game.removeVisual(self)
    }

    method efecto(zombie) {
      self.hacerDanio(zombie)
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


const unProyectil = new Proyectil() 

object proyectil1 inherits Proyectil { } 