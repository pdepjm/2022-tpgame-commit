import wollok.game.*
import personajes.*

object textoDelContador {
	const property position = game.at(22, 23)
	
	method text() = (personaje.bolasDeFuego().size()).toString() + "x" 

	method textColor() = "000000"
	
	method agregarse(){
		game.addVisual(self)
	}
}

object textoCurita {
    const property position = game.at(15, 22)
	
	method text() = "Te curaste toda la vida ❤️❤️❤️❤️❤️"

    method textColor() = "000000"
	
	method agregarse(){
		game.addVisual(self)
	}
}

object textoRelojDeArena {
    const property position = game.at(15, 22)
	
	method text() = "Ahora la velocidad de carga se realentizó un 50%"

    method textColor() = "000000"
	
	method agregarse(){
		game.addVisual(self)
	}
}