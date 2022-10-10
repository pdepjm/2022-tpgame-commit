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
		
		game.schedule(tiempoEnPantalla,{=> game.removeVisual(self)})

	}

} 

object curita inherits ElementoEspecial (imagen = "vendajeChico.png", tiempoHastaAparicion = 25000, tiempoEnPantalla= 35000){
	
	method chocasteConJugador() {
		personaje.aumentarTodaLaVida() 
		textoCurita.agregarse()
		game.schedule(5000, {game.removeVisual(textoCurita)})
		game.removeVisual(self)
	}
}

object relojDeArena inherits ElementoEspecial (imagen = "hora.png", tiempoHastaAparicion = 26000, tiempoEnPantalla = 37000){
 		
	method chocasteConJugador() {
		keyboard.r().onPressDo({personaje.recargarBalas(4500)})
		game.schedule(1000,{keyboard.r().onPressDo({personaje.recargarBalas()})})
		game.removeVisual(self)
		textoRelojDeArena.agregarse()
		game.schedule(5000, {game.removeVisual(textoRelojDeArena)})
	}
}



class Borde {
    const property position 

	method image() = "pared.png"

	method position() = position

    method agregarse() {
        game.addVisual(self)
		game.onCollideDo(self,{unElemento=>unElemento.chocasteConBorde()})
	}
	
	method chocasteConJugador() {}
    

}

object generacionBordes {
	

	method crearBordesIzquierdos(bordesDeUnNivel) {

		bordesDeUnNivel.add(game.height().times{n => new Borde(position = game.at(0,n))})
	}

}

const unProyectil = new Proyectil() 
