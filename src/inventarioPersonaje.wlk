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
	
	var property elCargador = [new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion)]
	
	method recargar() {
		elCargador = [new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion), new Proyectil(tipoProyectil = tipoMunicion)] 
	}

	method retirarUnaBala() {
		elCargador.remove(elCargador.head())
	}

	method tiempoDeRecarga() = 500

	method tamanio() = elCargador.size()
}