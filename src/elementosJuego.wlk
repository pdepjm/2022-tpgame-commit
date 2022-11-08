 import wollok.game.*
 import juego.*
 import personajePrincipal.*
 import enemigos.* 
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
    
    method chocasteConBorde() {
		game.removeVisual(self)
	}
	
    method chocasteConJugador() {}
    
    method agregarse(){
		game.addVisual(self)
	}


}
class TipoProyectil {
	const property imagen 
	const property velocidad
	const property danio
	const property tiempoDeRecarga
}

const enemigo = new TipoProyectil(imagen = "bolaWollok.png", velocidad = 100, danio = 1, tiempoDeRecarga = 500)
const comun = new TipoProyectil(imagen = "balaOriginal.png", velocidad = 100, danio = 1, tiempoDeRecarga = 500)
const chetado = new TipoProyectil(imagen = "bolaFuego.png", velocidad = 150, danio = 2, tiempoDeRecarga = 500)
const infinito = new TipoProyectil(imagen = "lapiz.png", velocidad = 150, danio = 2, tiempoDeRecarga = 1) 

class ProyectilEnemigo inherits Proyectil(tipoProyectil = enemigo) {


	override method mover() {
		position = game.at(position.x()-1, position.y())
	}

	override method chocasteConEnemigo(elEnemigo) { }

	override method chocasteConJugador() {
		personaje.disminuirVida()
	}
	
	
}


const unProyectil = new Proyectil(tipoProyectil = comun) 

/**********************       ELEMENTOS ESPECIALES      **********************/

class ElementoEspecial {
	var imagen
	var property position = game.center()
	const tiempoHastaAparicion
	const tiempoEnPantalla
	
	method image() = imagen

	method chocasteConEnemigo(unEnemigo) {}
	
	method agregarse() {

		position = aleatorio.dondeAparecer() 
		game.schedule(tiempoHastaAparicion,{=> self.apareceSiNoPerdio()})
		game.schedule(tiempoEnPantalla,{=> self.sacaloSiEsta()})
		
	}
	
	method sacaloSiEsta() {
		if (game.hasVisual(self))game.removeVisual(self)
		else {}
	}
	
	method apareceSiNoPerdio(){
		if(!game.hasVisual(gameOver)) game.addVisual(self)
	}

} 

object curita inherits ElementoEspecial (imagen = "vendajeChico.png", tiempoHastaAparicion = 15000, tiempoEnPantalla= 35000){
	
	method chocasteConJugador() {
		personaje.aumentarTodaLaVida() 
		game.say(self,"¡Te curaste toda la vida!")
	
		game.removeVisual(self)
	}
}


object balaChetada inherits ElementoEspecial (imagen = "bolaFuego.png", tiempoHastaAparicion = 25000, tiempoEnPantalla = 45000){
	
	override method agregarse() {

		position = game.center()
		game.schedule(tiempoHastaAparicion,{=> self.apareceSiNoPerdio()})
		game.schedule(tiempoEnPantalla,{=> self.sacaloSiEsta()})
		
	}

	method chocasteConJugador() {
		personaje.cargador().tipoMunicion(chetado)
		game.say(self,"¡Ahora disparás con más daño!")
		game.removeVisual(self)
		personaje.renovarCargador()
	}

}

object balaInfinito inherits ElementoEspecial (imagen = "lapiz.png", tiempoHastaAparicion = 30000, tiempoEnPantalla = 45000){
	
	override method agregarse() {

		position = game.center()
		game.schedule(tiempoHastaAparicion,{=> self.apareceSiNoPerdio()})
		game.schedule(tiempoEnPantalla,{=> self.sacaloSiEsta()})
		
	}
	
	method chocasteConJugador() {
		personaje.cargador().tipoMunicion(infinito)
		personaje.renovarCargador() 
		game.say(self,"¡Ahora tardas menos en recargar!")
		game.removeVisual(self)
	}

}

object mina inherits ElementoEspecial (imagen = "mina.png", tiempoHastaAparicion = 4000, tiempoEnPantalla = 39000){
	
	var property estaPlantada = false
	
	method chocasteConJugador(){ 
		if(!estaPlantada){
			keyboard.f().onPressDo({self.plantarseSoloUnaVez()})
			game.removeVisual(self)
			personaje.aumentarMinas(1)
			game.say(personaje, "Tenes una mina en el inventario! Plantala con F!")
		}
	}
	
	method plantarseSoloUnaVez() { 
		if (!estaPlantada ) self.plantarse()   
	}
	
	method plantarse() {
		if(personaje.minas()>0){
		self.position(personaje.position())
		game.addVisual(self)
		self.estaPlantada(true)
		personaje.aumentarMinas(-1)
		}
	}
	
	override method chocasteConEnemigo(elEnemigo) {
		if(estaPlantada) {
			elEnemigo.disminuirVida(6)
    		self.estaPlantada(false)
    		game.removeVisual(self)
    	}
	}
	
	override method agregarse() {
		self.estaPlantada(false)
		position = aleatorio.dondeAparecer() 
		game.schedule(tiempoHastaAparicion,{=> self.apareceSiNoPerdio()})
		game.schedule(tiempoEnPantalla,{=> self.sacalaSiNoEstaEnInventario()})
	}
	
	method sacalaSiNoEstaEnInventario() {
		if (personaje.minas()!=0) {}
		else self.sacaloSiEsta()
	}
	
}


