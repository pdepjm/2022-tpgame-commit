 import wollok.game.*
 import juego.*
 import personajePrincipal.*
 import enemigos.* 
 import texto.*
 import direcciones.*
 import niveles.*
 

/**********************       PROYECTILES       **********************/

class Proyectil {
    var property position = personaje.position()
    var property tipoProyectil

    method image() = tipoProyectil.imagen()

    method mover() {
		position = game.at(position.x()+1, position.y())
    }
   
    method trayectoria() {
    	game.onTick(tipoProyectil.velocidad(), "Movimiento proyectil",{self.mover()})
    }
    
    method chocasteConEnemigo(elEnemigo) {
    	elEnemigo.disminuirVida(tipoProyectil.danio())
    	game.removeVisual(self)
    }
    
    method chocasteConJugador() {}
}
class TipoProyectil {
	const property imagen 
	const property velocidad
	const property danio
}

const comun = new TipoProyectil(imagen = "bolaFuego.png", velocidad = 100, danio = 1)
const chetado = new TipoProyectil(imagen = "balaSuper150.png", velocidad = 150, danio = 2)

class ProyectilEnemigo inherits Proyectil(tipoProyectil = comun) {


	override method mover() {
		position = game.at(position.x()-1, position.y())
	}

	override method chocasteConEnemigo(elEnemigo) { }

	override method chocasteConJugador() {
		personaje.disminuirVida()
	}
	
	method chocasteConBorde() {
		game.removeVisual(self)
	}
}

object imagenDelContador {
	const property position = game.at(11, 11)
	
	method image() = personaje.cargador().tipoMunicion().imagen()
	
	method agregarse(){
		game.addVisual(self)
	}
	
}

const unProyectil = new Proyectil(tipoProyectil = comun) 

/**********************       PROYECTILES       **********************/




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
		game.say(self,"¡Te curaste toda la vida!")

		textoCurita.agregarse()
		game.schedule(5000, {game.removeVisual(textoCurita)})
		game.removeVisual(self)
	}
}

/* 

object relojDeArena inherits ElementoEspecial (imagen = "hora.png", tiempoHastaAparicion = 16000, tiempoEnPantalla = 37000){
 		
	method chocasteConJugador() {}
	
	override method chocasteConEnemigo(unEnemigo) {
		unEnemigo.quedateQuieto()
		game.removeVisual(self)
	}
}

*/

object balaChetada inherits ElementoEspecial (imagen = "balaSuper150.png", tiempoHastaAparicion = 2500, tiempoEnPantalla = 30000){
	
	method chocasteConJugador() {
		personaje.cargador().tipoMunicion(chetado)
		game.say(self,"¡Ahora disparás con más daño!")
		game.removeVisual(self)
	}

}

object mina inherits ElementoEspecial (imagen = "mina.png", tiempoHastaAparicion = 2500, tiempoEnPantalla = 39000){
	
	var property enInventario = false 
	var property estaPlantada = false
	method chocasteConJugador(){ 
		if(!estaPlantada){
			keyboard.f().onPressDo({self.plantarseSoloUnaVez()})
			game.removeVisual(self)
			self.ponerEnInventario()
		}
	}
	
	method plantarseSoloUnaVez() { 
		if (!estaPlantada) self.plantarse()
	}
	
	method plantarse() {
		//game.removeVisual(self)
		//game.addVisual(self)
		self.position(personaje.position())
		self.estaPlantada(true)
	}

	method ponerEnInventario(){
		enInventario = true
		self.position(game.at(11, 11))
		game.addVisual(self)
		game.say(personaje, "Tenes una mina en el inventario! Plantala con F!")
	}
	
	override method chocasteConEnemigo(elEnemigo) {
		if(estaPlantada) {hitSound.play()
		elEnemigo.disminuirVida(elEnemigo.vida())
    	game.removeVisual(self) }
	}
	
	override method agregarse() {

		position = aleatorio.dondeAparecer() 
		
		game.schedule(tiempoHastaAparicion,{=> game.addVisual(self)})
		
		game.schedule(tiempoEnPantalla,{=> self.sacalaSiNoEstaEnInventario()})
		
	}
	
	method sacalaSiNoEstaEnInventario() {
		
		if (enInventario) {
			
		}
		
		else {
			removeVisual(self)
		}
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
	method crearBordesIzquierdos(bordesDeUnNivel) { 
		
		(game.height()-1).times({n => self.crearUnBordeEnLista(n-1, bordesDeUnNivel)})
		
	}
	method crearUnBordeEnLista(posicion,listaBordes) = listaBordes.add(new Borde(position = game.at(0,posicion)))
}


class Visual {
	var property image
	var property position
	
	method chocasteConBorde(){
		
	}
	
}



