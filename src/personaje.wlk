import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import enemigos.*

object personaje {

    var property vida = vidaPersonaje.vida() 

    var property bolasDeFuego = [new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil(), new Proyectil()]

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


object vidaPersonaje {

	const property vidaInicial = [new Corazon(position = game.at(2,23)), new Corazon(position = game.at(3,23)), new Corazon(position = game.at(4,23)), new Corazon(position = game.at(5,23)), new Corazon(position = game.at(6,23))]
	
	var vida = vidaInicial 

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