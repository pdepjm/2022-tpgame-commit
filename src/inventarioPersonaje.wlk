import wollok.game.*
 import juego.*
 import personajePrincipal.*
 import enemigos.* 
 import texto.*
 import direcciones.*
 import niveles.*
 import elementosJuego.*

 class Inventario {
	const property position
	method image() = "inventarioPared.png" 

	method agregarse(){
		game.addVisual(self)
	}
	
	method chocasteConBorde() {
		
	}
	
	
 }

const cuadrado1 = new Inventario(position=game.at(11,11))
const cuadrado2 = new Inventario (position=game.at(10,11))

const inventario = [cuadrado1,cuadrado2]

 
 object municion {
	
	var property tipoMunicion = comun 
	
	var property elCargador = 
			[new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion)]
	
	method recargar() {
		elCargador =
			[new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion)] 
	}

	method retirarUnaBala() {
		elCargador.remove(elCargador.head())
	}

	method tiempoDeRecarga() = 500

	method tamanio() = elCargador.size()
}