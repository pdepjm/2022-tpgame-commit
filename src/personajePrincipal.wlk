import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import inventarioPersonaje.*


object personaje {

	/************    ATRIBUTOS    ***************/
    var property vida = [new Corazon (image = "corazon0.png"), new Corazon(image = "corazon1.png"), new Corazon(image = "corazon2.png"), new Corazon(image = "corazon3.png"), new Corazon(image = "corazon4.png"), new Corazon(image = "corazon5.png")]
	var property enemigosMatados = 0
	var property nivelActual = nivel_1
    var property position = game.center()
	const property cargador = municion

	method image() = "personaje.png"   
	
	/************    CONFIG INICIAL    ***************/
    method configurarAcciones() {
			
		vida.forEach{corazon => corazon.agregarse()}
		cargador.agregarProyectiles()
		game.onCollideDo(self,{unElemento => unElemento.chocasteConJugador()})
		
	}
	
	method moverA(unaDireccion) {
		
		position = unaDireccion.siguientePosicion(position)
	}
	
	/************    MODIFICAR VIDA    ***************/
	
	method aumentarTodaLaVida() {
		
		vida = [new Corazon (image = "corazon0.png"), new Corazon(image = "corazon1.png"), new Corazon(image = "corazon2.png"), new Corazon(image = "corazon3.png"), new Corazon(image = "corazon4.png"), new Corazon(image = "corazon5.png")]
		vida.forEach{corazon => corazon.agregarse()}	
	}
	
	method disminuirVida() {

		if (vida.size() > 0) {
		 
			hitSound.play()
			game.removeVisual(vida.last())
			vida.remove(vida.last())
		}
		
		if(vida.size()-1 == 0)
		{
			self.nivelActual().musica().stop()
			gameOver.finalizarJuego()
		}
	}
	
	/************   CHOCAR CON    ***************/
	
	method chocasteConEnemigo(unEnemigo) {
		self.disminuirVida() 
	}

	method chocasteConBorde(){}
	
	/************    ARMA    ***************/
	
	method recargarBalas() {
		
		if (cargador.tamanio() == 0) {
			
			game.say(self, "Recargando, espere unos segundos")
			game.schedule(cargador.tiempoDeRecarga(), {cargador.recargar()})
			cargador.agregarProyectiles()
			
		}
		else game.say(self, "Todavía no es momento de recargar porque tenés " + cargador.tamanio().toString())
	}

	method renovarCargador() {
		
		cargador.recargar() 
	}
	
	method disparar() {
		
		if (cargador.tamanio() > 0) {
		
			const otroProyectil = new Proyectil(tipoProyectil = municion.tipoMunicion())
			game.addVisual(otroProyectil)
			otroProyectil.trayectoria()
			cargador.retirarUnaBala()	
		}
		else {game.say(self, "Estoy sin munición, recargar con r")}
	}
	
	/************    PASAR DE NIVEL    ***************/
	
	method sumarPuntos(){
		
		enemigosMatados+=1 

		if(enemigosMatados == nivelActual.puntosAConseguir() ){
			game.say(self,"¡Pasaste de nivel!")
			
			nivelActual.configurarSiguienteNivel()
			nivelActual = nivelActual.siguienteNivel()
			enemigosMatados = 0
		}
	}


	
}

class Corazon {
    const property position = game.at(0,11)
    
    var property image
	
	method agregarse(){
		game.addVisual(self)
	}
	
	method chocasteConBorde(){
		
	}
}