 import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*


object personaje {
	
	const cargador = [new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()]

    var property vida = [corazon1, corazon2, corazon3, corazon4, corazon5]
    
    var property bolasDeFuego = cargador 

    var property position = game.center()

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)
	}
	
	method perderVida() {
		hitSound.play()
		game.removeVisual(vida.last())
		vida.remove(vida.last())
		
		if(vida.size() == 0)
		{
			game.addVisual(fin)
		}
	}

	method disparar() {
		
		if (bolasDeFuego.size() > 0) {
			const otroProyectil = new Proyectil() 
		
			game.addVisual(otroProyectil)
		
			otroProyectil.trayectoria()
		
			bolasDeFuego.remove(bolasDeFuego.last())
		}
		else {
			game.say(self, "Estoy sin bolas de fuego, recargalas con r")
		}
	}
	
	method morir() { }
	
	method recargarBalas() {
		
		if (bolasDeFuego.size() == 0) {
			
			game.schedule(1000, {self.bolasDeFuego(cargador)})
			
		}
		
		else {
			
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + bolasDeFuego.size().toString())
		}
	
			
			}
}

class Zombie {
	
	var property position 
	
	var x  = position.x()
	method image() = "zombie.png"

	method moverse() {
		x -= 1
		position = game.at(x, position.y())
	}
	
	method hacerDanio(personaje) {
		personaje.perderVida()
	}
	
	method morir() {
		game.removeVisual(self)
	}
	
	method agregarse() {
		 game.addVisual(self)
		 game.onCollideDo(self, {elemento => elemento.efecto(self)})
	}
	
}




object zombie1 {
	
	var property position = game.at(23, 12)
	
	var x = 23
	const y = 12

	method image() = "zombie.png"

	method moverse() {
		x -= 1
		position = game.at(x, y)
	}
	
	method hacerDanio(personaje) {
		personaje.perderVida()
	}
	
	method morir() {
		game.removeVisual(self)
	}
	
}























