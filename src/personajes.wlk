import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*

object personaje {

    var property vida = [new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23)), new Corazon(position = game.at(5,23)), new Corazon(position = game.at(6,23))]

    var property bolasDeFuego = [new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil()]

    var property position = game.center()
	
    method image() = "personaje.png"
	
    method moverA(direccion) {
			position = direccion.siguientePosicion(position)
	}
	
	method aumentarTodaLaVida() {
		
		vida = [new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23)), new Corazon(position = game.at(5,23)), new Corazon(position = game.at(6,23))]
		vida.forEach{corazon => corazon.agregarse()}
		
	}

	
	method disminuirVida() {
		if (vida.size() > 0) {
		 
			hitSound.play()
			game.removeVisual(vida.last())
			vida.remove(vida.last())
		 	
		}
	
		
		if(vida.size() == 0)
		{
			gameOver.finalizarJuego()
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
		method configurarAcciones() {

			vida.forEach{corazon => corazon.agregarse()}
			game.onCollideDo(self,{unElemento => unElemento.chocasteConJugador()})
		
	}
	
	
	method recargarBalas() {
		
		if (bolasDeFuego.size() == 0) {
			game.say(self, "Recargando balas, espere unos segundos")
			game.schedule(2000, {self.bolasDeFuego([new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil()])})
			
			
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + bolasDeFuego.size().toString())
	}
	
	method recargarBalas(tiempo) {
		
		if (bolasDeFuego.size() == 0) {
			game.say(self, "Recargando balas, espere unos segundos")
			game.schedule(tiempo, {self.bolasDeFuego([new Proyectil(), new Proyectil(), new Proyectil(),new Proyectil(), new Proyectil()])})
			
			
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + bolasDeFuego.size().toString())
	}


	method chocasteConEnemigo(unEnemigo) {
		self.disminuirVida() 
	}

	method chocasteConBorde(){
	}

	method plantarMina(unaMina){
		
	}
}

class Enemigo {
	
	var property position
	var property especie
	var property vida = especie.vida()
	var property image = especie.image()

	method moverse() {
		
		position = position.left(1)
	}
	
	
	method disminuirVida() {
		
		
		if (vida > 0) 
			
			vida -= 1
		
		if (vida<=0) 
			game.removeVisual(self)
			
		
	}
	
	method agregarse() {
		 game.addVisual(self)
		 game.onCollideDo(self,{unElemento=>unElemento.chocasteConEnemigo(self)})
	     game.onTick(especie.velocidad(), "Movimiento Enemigo", {self.moverse()})
		
	}
	
	method chocasteConJugador() {}

	method chocasteConBorde() {
		gameOver.finalizarJuego() 
	}
	
}

class EspecieZombie {
	var property vida
	const property image
	var property velocidad 
		
}

class EspecieBoss {
	var property vida
	const property image
	var property velocidad

	method dispararPersonaje() {

		const proyEnemigo = new ProyectilEnemigo() 
		
		game.addVisual(proyEnemigo)
		
		proyEnemigo.trayectoria()
	}
}


const zombieBeta = new EspecieZombie (vida = 1, image = "zombie.png", velocidad = 1000)
const zombieAlfa = new EspecieZombie (vida = 2, image = "zombieAlfa.png", velocidad = 1500)

const boss = new EspecieBoss(vida = 7, image = "wollokGigante.png", velocidad = 4000)







