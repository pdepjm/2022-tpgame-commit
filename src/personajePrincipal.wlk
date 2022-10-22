import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import inventarioPersonaje.*


object personaje {

    var property vida = [new Corazon(image = "corazon1.png"), new Corazon(image = "corazon2.png"), new Corazon(image = "corazon3.png"), new Corazon(image = "corazon4.png"), new Corazon(image = "corazon5.png")]

	const property cargador = municion
	
	var enemigosMatados = 0
	

	
	var property nivelActual = primerNivel 

    var property position = game.center()
	    
	method enemigosMatados(cant) {
		enemigosMatados = cant
	}
	
	method image() = "personaje.png"
		
    
	method moverA(direccion) {
			position = direccion.siguientePosicion(position)
	}
	
	method sumarPuntos(){
		
		enemigosMatados+=1 

		if(enemigosMatados == nivelActual.puntosAConseguir()){
			game.say(self,"¡Pasaste de nivel!")
			nivelActual.configurarSiguienteNivel()
		}
		
		else {
			
		}

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
			const otroProyectil = new Proyectil(tipoProyectil = municion.tipoMunicion())
		
			game.addVisual(otroProyectil)
		
			otroProyectil.trayectoria()
			
			cargador.retirarUnaBala()
			
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

class Corazon {
    const property position = game.at(0,11)
    
    var property image
	
	method agregarse(){
		game.addVisual(self)
	}
}

