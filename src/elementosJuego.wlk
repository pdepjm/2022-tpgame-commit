 import wollok.game.*
 import juego.*
 import personajes.*
 import texto.*
 
 
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

class Elementos {
	var imagen
	var param1
	var param2
	
	method image() = imagen
	method agregarse() {
		game.schedule(param1,{=> game.addVisual(self)})
		game.schedule(param2,{=> game.removeVisual(self)})
		}
		
	method chocasteConEnemigo(unEnemigo) {
		}
} 

object curita inherits Elementos(imagen = "vendajeChico.png", param1 = 20000, param2 = 25000){
	var property position = game.center()
	
	method chocasteConJugador() {
		personaje.aumentarTodaLaVida() 
		textoCurita.agregarse()
		game.schedule(5000, {game.removeVisual(textoCurita)})
		game.removeVisual(self)
	}
}

object relojDeArena inherits Elementos (imagen = "hora.png", param1 = 16000, param2 = 26000){
	var property position = game.at(16,16)
		
	method chocasteConJugador() {
		keyboard.r().onPressDo({personaje.recargarBalas(4500)})
		game.schedule(1000,{keyboard.r().onPressDo({personaje.recargarBalas()})})
		game.removeVisual(self)
		textoRelojDeArena.agregarse()
		game.schedule(5000, {game.removeVisual(textoRelojDeArena)})
	}
}

object borde {

	const position = game.at(0,0)

	method position() = position

	method image() = "bordes.png"

	method configuracionInicial(){
		game.addVisual(self)
		game.onCollideDo(self,{unElemento=>unElemento.chocasteConBorde()})
	}
}

const unProyectil = new Proyectil() 
