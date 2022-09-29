import wollok.game.*
import direcciones.* 

object personaje {

    var position = game.center()

    method position() = position

    method image() = "personaje.png"

   method moverA(direccion) {
		position = direccion.siguientePosicion(position) 
	}

}





