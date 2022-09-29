 import wollok.game.*
import direcciones.* 


object personaje {

    var property vida

    var position = game.center()

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)

    method disparar() {}
	}

}

object vidaPersonaje {
    
    var cantidadVida = 50

    var corazones = [corazon1, corazon2, corazon3, corazon4, corazon5]
    

    method perderVida() {

    }
}

class Corazon {
    
    method image() = "corazon.png"
    
    
    method posicion() //cada corazon va a tener una posicion distinta en la pantalla

    method cambiarEstado() { //


    }


}

object corazon


object corazonVacio {

}


class Enemigo {
    var vida 
    const danio

    

}




class Zombie inherits Enemigo {
    

   


}


class Esqueleto inherits Enemigo {


}









