import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*

object personaje {

    var property vida = [new Corazon(position = game.at(0,23)), new Corazon(position = game.at(1,23)), new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23))]

    var property bolasDeFuego = [new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()]

    var property position = game.center()

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
    	
		position = direccion.siguientePosicion(position)
	}

	
	method disminuirVida() {
		hitSound.play()
		game.removeVisual(vida.last())
		vida.remove(vida.last())
		
		if(vida.size() == 0)
		{
			gameOver.finalizarJuego()
		}
	}

	method disparar() {
		
		//game.onCollideDo(self,{unPersonaje=>unPersonaje.chocasteConProyectil()})
	
		if (bolasDeFuego.size() > 0) {
			const otroProyectil = new Proyectil() 
		
			game.addVisual(otroProyectil)
		
			otroProyectil.trayectoria()
			
			bolasDeFuego.remove(bolasDeFuego.head())
			
		}
		else {
			game.say(self, "Estoy sin bolas de fuego, recargalas con r")
		}
}
		method configurarAcciones() {

			vida.forEach{corazon => corazon.agregarse()}
		
	}
	
	
	method recargarBalas() {
		
		if (bolasDeFuego.size() == 0) {
			game.schedule(500, {self.bolasDeFuego([new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()])})
			game.say(self, "Recargando balas, espere unos segundos")
			
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + bolasDeFuego.size().toString())
	}


	method chocasteConEnemigo(unEnemigo) {
		self.disminuirVida() 
	}
}

class Enemigo {
	
	var property position
	var property vida
	var property velocidad 
	
	var x  = position.x()

	method moverse() {
		x -= 1 
		position = game.at(x, position.y())

		if(position.x() < 0) {     
			gameOver.finalizarJuego()
		}
	}
	
	
	method disminuirVida() {
		vida -= 1
		
		if(vida == 0)
		{
			game.removeVisual(self)
		}
	}
	
	method agregarse() {
		 game.addVisual(self)
		 game.onCollideDo(self,{unElemento=>unElemento.chocasteConEnemigo(self)})
	     game.onTick(velocidad, "Movimiento Enemigo", {self.moverse()})
		
	}

	
}

class Zombie inherits Enemigo (vida = 1, velocidad = 1000) {
	
	
	method image() = "zombie.png"


	
}

class ZombieAlfa inherits Enemigo (vida = 2, velocidad = 750) {
	
	method image() = "zombieAlfa.png"

	
}
























