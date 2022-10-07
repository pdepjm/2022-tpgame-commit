import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*

object personaje {

    var property vida = [new Corazon(position = game.at(0,23)), new Corazon(position = game.at(1,23)), new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23))]

    var property bolasDeFuego = [new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()]

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
			
			bolasDeFuego.remove(bolasDeFuego.head())
			
		}
		else {
			game.say(self, "Estoy sin bolas de fuego, recargalas con r")
		}
	}
	
	method morir() { }
	
	method recargarBalas() {
		
		if (bolasDeFuego.size() == 0) {
			game.schedule(1500, {self.bolasDeFuego([new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()])})
			game.say(self, "Recargando bolas, espere 15 segundos")
			
		}
		else 
			game.say(self, "Todavía no es momento de recargar bolas porque tenés " + bolasDeFuego.size().toString())
	}
}

class Enemigo {
	
	var property position
	var property vida
	var property image
	var property velocidad 
	
	var x  = position.x()

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
	     game.onTick(velocidad, "Movimiento Enemigo", {self.moverse()})
		 game.onCollideDo(self, {elemento => elemento.efecto(self)})
	}
	
}

class ZombieBeta inherits Enemigo (vida = 1, image = "zombie.png", velocidad = 1000){	
	
}

class ZombieAlfa inherits Enemigo (vida = 2, velocidad = 750) {

	
}


class ExtraVida {
	

}

























