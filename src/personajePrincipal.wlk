import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import inventarioPersonaje.*


object personaje {

	/************    ATRIBUTOS    ***************/
    var property vida = 5
	var property enemigosMatados = 0
	var property nivelActual = nivel_1
    var property position = game.center()
	const property cargador = municion
	var property minas = 0


	method image() = "personaje.png"   
	
	/************    CONFIG INICIAL    ***************/
    
	method configuracionInicial() {
		self.agregarse()
		game.onCollideDo(self,{unElemento => unElemento.chocasteConJugador()})
		minaInventario.agregarse()
		
	}
	
	method agregarse() {	
		cargador.agregarProyectiles()
		self.aumentarTodaLaVida()
		self.minas(0)
		game.addVisual(self)
		self.renovarCargador()
	}
	
	method agregarVida(){
			corazon.agregarse()
			
	}
	
	method moverA(unaDireccion) {
		
		position = unaDireccion.siguientePosicion(position)
	}
	
	/************    MODIFICAR VIDA    ***************/
	
	method aumentarTodaLaVida() {
		
		vida = 5
			
	}
	
	method disminuirVida() {

		if (vida > 0) {
		 	
		 	vida -=1 
			hitSound.play()
			
		}
		
		if(vida == 0)
		{
			self.nivelActual().musica().stop()
			nivelActual.perder()
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
		
		if (cargador.tamanio() > 0 && game.hasVisual(self)) {
		
			const otroProyectil = new Proyectil(tipoProyectil = municion.tipoMunicion())
			game.addVisual(otroProyectil)
			otroProyectil.trayectoria()
			cargador.retirarUnaBala()	
		}
		else {game.say(self, "Estoy sin munición, recargar con r")}
	}
	
	/************    PASAR DE NIVEL    ***************/
	
	method sumarPuntos(){
		
		enemigosMatados++ 
		game.say(corazon,"cant"+enemigosMatados)

		if(enemigosMatados == nivelActual.puntosAConseguir() ){
			
			nivelActual.eliminarTodo()
			if(nivelActual!=nivel_3){
					nivelActual = nivelActual.siguienteNivel()}
			enemigosMatados = 0
		}
	}
	
	method aumentarMinas(cantMinas){
		minas = (minas + cantMinas).max(0)
	}

	
}

object corazon {
    const property position = game.at(0,11)
    
   method image() = "corazon" + personaje.vida() + ".png"
	
	method agregarse(){
		if (!game.hasVisual(self)) game.addVisual(self)
	}
	
	method chocasteConBorde(){
		
	}
	

}