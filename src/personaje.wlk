import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import enemigos.*

object personaje {

    var property vida = [new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23)), new Corazon(position = game.at(5,23)), new Corazon(position = game.at(6,23))]

	const property cargador = municion
	
	
    var property position = game.center()
	    
	method image() = "personaje.png"
    
	method moverA(direccion) {
			position = direccion.siguientePosicion(position)
	}
	
	method tiempoDeRecarga() = cargador.tiempoDeRecarga()
	
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
