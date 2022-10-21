import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*

object personaje {

    var property vida = [new Corazon(image = "corazon1.png"), new Corazon(image = "corazon2.png"), new Corazon(image = "corazon3.png"), new Corazon(image = "corazon4.png"), new Corazon(image = "corazon5.png")]

	const property cargador = municion
	
	
    var property position = game.center()
	    
	method image() = "personaje.png"
    
	method moverA(direccion) {
			position = direccion.siguientePosicion(position)
	}
	
	method tiempoDeRecarga() = cargador.tiempoDeRecarga()
	
	method aumentarTodaLaVida() {
		
		vida = [new Corazon(image = "corazon1.png"), new Corazon(image = "corazon2.png"), new Corazon(image = "corazon3.png"), new Corazon(image = "corazon4.png"), new Corazon(image = "corazon5.png")]
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
		
		if (cargador.tamanio() > 0) {
			const otroProyectil = new Proyectil() 
		
			game.addVisual(otroProyectil)
		
			otroProyectil.trayectoria()
			
			cargador.disparar()
			
		}
		else {
			game.say(self, "Estoy sin bolas de fuego, recargalas con r")
		}
	}
	
		method configurarAcciones() {

			
			vida.forEach{corazon => corazon.agregarse()}

			game.onCollideDo(self,{unElemento => unElemento.chocasteConJugador()})
		
	}
	
	method recargarBalas(tiempo) {
		
		if (cargador.tamanio() == 0) {
			
			game.say(self, "Recargando balas, espere unos segundos")
			game.schedule(tiempo, {cargador.recargar()})
			
		
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + cargador.tamanio().toString())
	}


	method chocasteConEnemigo(unEnemigo) {
		self.disminuirVida() 
	}

	method chocasteConBorde(){
	}

	method plantarMina(unaMina){
		
	}
}

object municion {
	
	var property tipoMunicion = comun 
	
	var property elCargador = [tipoMunicion,tipoMunicion,tipoMunicion,tipoMunicion,tipoMunicion]
	
	method recargar() {
		elCargador = [tipoMunicion,tipoMunicion,tipoMunicion,tipoMunicion,tipoMunicion] 
	}

	method disparar() {
		elCargador.remove(elCargador.head())
	}

	method tiempoDeRecarga() = 2000

	method tamanio() = elCargador.size()

	}
	
const comun = new Proyectil() 

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







