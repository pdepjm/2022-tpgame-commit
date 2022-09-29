import wollok.game.*
import direcciones.* 

object personaje {

    var position = game.center()

    method position() = position

    method image() = "guy.png"

   method moverA(direccion) {
		position = direccion.siguientePosicion(position) 
	}

}





