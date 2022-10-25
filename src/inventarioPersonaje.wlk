import wollok.game.*
 import juego.*
 import personajePrincipal.*
 import enemigos.* 
 import texto.*
 import direcciones.*
 import niveles.*
 import elementosJuego.*
 
 object municion {
	
	var property tipoMunicion = comun 
	
	var property elCargador =[new Proyectil(tipoProyectil = tipoMunicion, position = game.at(11,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(10,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(9,11)),new Proyectil(tipoProyectil = tipoMunicion, position = game.at(8,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(7,11))]
	
	method recargar() {
		elCargador.forEach{proyectil=>game.removeVisual(proyectil)}
		elCargador =
			[new Proyectil(tipoProyectil = tipoMunicion, position = game.at(11,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(10,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(9,11)),new Proyectil(tipoProyectil = tipoMunicion, position = game.at(8,11)), new Proyectil(tipoProyectil = tipoMunicion, position = game.at(7,11))]
			self.agregarProyectiles()
	}
	
	method agregarProyectiles(){
		elCargador.forEach{proyectil=> proyectil.agregarse()}
	}
	method retirarUnaBala() {
		game.removeVisual(elCargador.last())
		elCargador.remove(elCargador.last())
	}

	method tiempoDeRecarga() = tipoMunicion.tiempoDeRecarga()

	method tamanio() = elCargador.size()
}

