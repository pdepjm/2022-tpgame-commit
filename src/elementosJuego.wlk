 import wollok.game.*
 import juego.*
 import personajes.*
 import texto.*
 import direcciones.*
 
 
class Corazon {
    const property position
    
	method image() = "corazon4.png"
	
	method agregarse(){
		game.addVisual(self)
	}
}

class Proyectil {

    var property position = personaje.position()

    method image() = "bolaFuego.png"

    method mover() {
		position = game.at(position.x()+1, position.y())
    }
   
    method trayectoria() {
    	game.onTick(100, "Movimiento proyectil",{self.mover()})
    }
    
    method chocasteConEnemigo(elEnemigo) {
    	elEnemigo.disminuirVida()
    	game.removeVisual(self)
    }
    
    method chocasteConJugador() {
    	
    }
	
}

object imagenDelContador {
	const property position = game.at(23, 23)
	
	method image() = "bolaFuego.png"
	
	method agregarse(){
		game.addVisual(self)
	}
	
}

class ElementoEspecial {
	var imagen
	var property position = game.center()
	const tiempoHastaAparicion
	const tiempoEnPantalla
	
	method image() = imagen

	method chocasteConEnemigo(unEnemigo) {
		}
	
	method agregarse() {

		position = aleatorio.dondeAparecer() 
		
		game.schedule(tiempoHastaAparicion,{=> game.addVisual(self)})
		
		game.schedule(tiempoEnPantalla,{=> self.sacaloSiEsta()})
		
	}
	
	method sacaloSiEsta() {
		
		if (game.hasVisual(self))
			game.removeVisual(self)
		else {}
	}

} 

object curita inherits ElementoEspecial (imagen = "vendajeChico.png", tiempoHastaAparicion = 15000, tiempoEnPantalla= 35000){
	
	method chocasteConJugador() {
		personaje.aumentarTodaLaVida() 
		textoCurita.agregarse()
		game.schedule(5000, {game.removeVisual(textoCurita)})
		game.removeVisual(self)
	}
}

object relojDeArena inherits ElementoEspecial (imagen = "hora.png", tiempoHastaAparicion = 16000, tiempoEnPantalla = 37000){
 		
	method chocasteConJugador() {
		keyboard.r().onPressDo({personaje.recargarBalas(4500)})
		game.schedule(1000,{keyboard.r().onPressDo({personaje.recargarBalas()})})
		game.removeVisual(self)
		textoRelojDeArena.agregarse()
		game.schedule(5000, {game.removeVisual(textoRelojDeArena)})
	}
}

object mina inherits ElementoEspecial (imagen = "mina.png", tiempoHastaAparicion = 2500, tiempoEnPantalla= 39000){
	//habría que agregarlo en el nivel que corresponda
	var property estaPlantada = false
	method chocasteConJugador(){ 
		if(!estaPlantada){
			keyboard.f().onPressDo({self.plantarse()})
			game.removeVisual(self)
			self.ponerEnInventario()
		}
	}
	
	method plantarse() {
		//game.removeVisual(self)
		//game.addVisual(self)
		self.position(personaje.position())
		self.estaPlantada(true)
	}

	method ponerEnInventario(){
		self.position(game.at(11, 11))
		game.addVisual(self)
		game.say(personaje, "Tenes una mina en el inventario! Plantala con F!")
	}
	
	override method chocasteConEnemigo(elEnemigo) {
		if(estaPlantada) {hitSound.play()
		game.removeVisual(elEnemigo)
    	game.removeVisual(self) }
	}
}



class Borde {
    const property position 

	method image() = "paredAmpliada.png"

	method position() = position

    method agregarse() {
        game.addVisual(self)
		game.onCollideDo(self,{unElemento=>unElemento.chocasteConBorde()})
	}
	
	method chocasteConJugador() {}
	
	method chocasteConEnemigo(unEnemigo) {}
    

}

object generacionBordes {
	

	method crearBordesIzquierdosEn(bordesDeUnNivel) {

		game.height().times({n => self.crearUnBordeEnLista(n-1, bordesDeUnNivel)})  
	
	}
	
	method crearUnBordeEnLista(posicion,listaBordes) = listaBordes.add(new Borde(position = game.at(0,posicion)))

}

const unProyectil = new Proyectil() 
