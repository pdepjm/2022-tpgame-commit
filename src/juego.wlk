import wollok.game.*
import personajePrincipal.*
import enemigos.*
import direcciones.*
import elementosJuego.*
import niveles.*

object juego {
	
	method iniciar() {
		self.configurarJuego()
		nivel_0.configuracionInicial()
		game.start()
		
	}

	method configurarJuego() {
		game.title("Juego")
		game.width(12)
		game.height(12)
		game.cellSize(100)
	}

	method agregarPersonajes() {
		game.addVisual(personaje)
		teclado.configurarTeclas()
	}

}

object teclado {
	
	method configurarTeclas() {
		keyboard.up().onPressDo({personaje.moverA(arriba)})
		keyboard.right().onPressDo({personaje.moverA(derecha)})
		keyboard.left().onPressDo({personaje.moverA(izquierda)})  
		keyboard.down().onPressDo({personaje.moverA(abajo)}) 
		keyboard.space().onPressDo({personaje.disparar()})
		keyboard.r().onPressDo({personaje.recargarBalas()})
		
	}
}

object gameOver {
	
	method position() = game.at(0,0)
	method image() = "gameOver grande.png"
	method finalizarJuego(){
		
		if (!game.hasVisual(self)) { 
			game.schedule(400, {game.clear()})
			game.addVisual(self) 
			music1.stop() 
		}
			
	}
	method chocasteConJugador(){}

	method chocasteConBorde(){}
}
/*********** BORDES *************/
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
	method crearBordesIzquierdos(bordesDeUnNivel) { 
		
		(game.height()-1).times({n => self.crearUnBordeEnLista(n-1, bordesDeUnNivel)})
		
	}
	method crearUnBordeEnLista(posicion,listaBordes) = listaBordes.add(new Borde(position = game.at(0,posicion)))
}


/*****Fondos y musica ****/
class Visual {
	var property image
	var property position
	
	method chocasteConBorde(){}
}

const fondoIntroNivel_0 = new Visual (image = "fondoInicial.png", position = game.at(0,0))
const fondoIntroNivel_1 = new Visual (image = "LEVEL1.png", position = game.at(0,0))
const fondoIntroNivel_2 = new Visual (image = "LEVEL2.png", position = game.at(0,0))
const fondoIntroNivel_3 = new Visual (image = "LEVEL3.png", position = game.at(0,0))
const fondoNivel_1 = "grass00.png"
const fondoNivel_2 = new Visual(image = "lava.jpg", position = game.at(1,0))
const fondoNivel_3 = new Visual (image = "fondo3.png", position = game.at(1,0))
const finDeJuego = new Visual (image = "FIN.png", position = game.at(0,0))

object music1 {
	
	const theme = game.sound("music2.mp3")
	
	method play() {
		theme.volume(0.1)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
	
	method stop() {
		theme.stop()
	}
}

object hitSound {
		
	method play() {
		game.sound("hit.mp3").play()
	}
}


