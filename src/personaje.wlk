import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import enemigos.*

object personaje {

    var property vida = vidaPersonaje.vida() 

	var property cargador = cargadorComun.cargarMunicion() 

    var property position = game.center()
	
    method image() = "personaje.png"
	
    method moverA(direccion) {
			position = direccion.siguientePosicion(position)
	}
	
	method aumentarTodaLaVida() {
		
		vida.aumentateToda()	
	}

	
	method disminuirVida() {

		vida.disminuirVida()
	}

	method disparar() {
		
		if (cargador.size() > 0) {

			var proyectil = cargador.head()
		
			game.addVisual(proyectil)
		
			proyectil.trayectoria()
			
			cargador.remove(proyectil)
			
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
		
		if (cargador.size() == 0) {
			
			game.say(self, "Recargando balas, espere unos segundos")
			game.schedule(tiempo, {cargador.cargarMunicion()})
			
		
		}
		else 
			game.say(self, "Todavía no es momento de recargar balas porque tenés " + cargador.size().toString())
	}


	method chocasteConEnemigo(unEnemigo) {
		self.disminuirVida() 
	}

	method chocasteConBorde(){
	}

	method plantarMina(unaMina){
		
	}
}


object vidaPersonaje {

	const property vidaInicial = [new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23)), new Corazon(position = game.at(5,23)), new Corazon(position = game.at(6,23))]
	
	var vida = vidaInicial 

	method vida() =  vida 

	method disminuir() {

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

	method aumentarTodaLaVida() { 

		vida = vidaInicial 
		vida.forEach{corazon => corazon.agregarse()}

	}
	


}


object cargadorComun {

	method cargarMunicion() = [new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil()]
}