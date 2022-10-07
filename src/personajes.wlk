import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*

object personaje {

    var property vida = [new Corazon(position = game.at(0,23)), new Corazon(position = game.at(1,23)), new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23))]

    var property bolasDeFuego = [new Proyectil(position = game.at(19,23)), new Proyectil(position = game.at(20,23)), new Proyectil(position = game.at(21,23)),new Proyectil(position = game.at(22,23)), new Proyectil(position = game.at(23,23))]

    var property position = game.at(5,13)

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)
	}

	method efecto(zombie) {
		self.perderVida() 
	}
	
	method perderVida() {
		hitSound.play()
		game.removeVisual(vida.last())
		vida.remove(vida.last())
		
		if(vida.size() == 0)
		{
			game.addVisual(gameOver)
		}
	}

	method disparar() {
		
		if (bolasDeFuego.size() > 0) {
			const otroProyectil = new Proyectil() 
		
			game.addVisual(otroProyectil)
		
			otroProyectil.trayectoria()
			
			game.removeVisual(bolasDeFuego.head())
			bolasDeFuego.remove(bolasDeFuego.head())
			
		}
		else {
			game.say(self, "Estoy sin bolas de fuego, recargalas con r")
		}
	}
	
	method morir() { }
	
	method recargarBalas() {
		
		if (bolasDeFuego.size() == 0) {
			game.schedule(1500, {self.bolasDeFuego([new Proyectil(position = game.at(19,23)), new Proyectil(position = game.at(20,23)), new Proyectil(position = game.at(21,23)),new Proyectil(position = game.at(22,23)), new Proyectil(position = game.at(23,23))])})
			game.schedule(1500, {self.bolasDeFuego().forEach{bola => bola.agregarse()}})
			game.say(self, "Recargando balas, espere 15 segundos")
			
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + bolasDeFuego.size().toString())
	}
}

class Zombie {
	
	var property position 
	var property vida = 1
	
	var x  = position.x()
	
	method image() = "zombie.png"

	method moverse() {
		x -= 1
		position = game.at(x, position.y())

		if(position.x() < 0) {     
			game.addVisual(gameOver)
		}
	}
	
	method hacerDanio(personaje) {
		personaje.perderVida()
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
	     game.onTick(1000, "Movimiento Zombie", {self.moverse()})
		 game.onCollideDo(self, {elemento => elemento.efecto(self)})
	}
	
}




/*object zombie1 {
	
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
	
}*/ 























