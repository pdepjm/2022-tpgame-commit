 import wollok.game.*
 import juego.*
 import personajes.*
 
 
class Corazon {
    const property position
    
	method image() = "corazon4.png"
	
	method agregarse(){
		game.addVisual(self)
	}

    method cambiarEstado() {
    
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
    
    method hacerDanio(enemigo) {
    	enemigo.morir()
    }

    method efecto(zombie) {
      self.hacerDanio(zombie)
    }

}

const unProyectil = new Proyectil() 

object proyectil1 inherits Proyectil { } 