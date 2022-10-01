 import wollok.game.*
 import juego.*
 import personajes.*
 
 
class Corazon {
    
    
	method image() = "corazon4.png"
    

    method cambiarEstado() {
    
    }


}

object corazon1 inherits Corazon {
	
	const property position = game.at(0,23)
	
}


object corazon2 inherits Corazon {
	
	const property position = game.at(1,23)
	
}


object corazon3 inherits Corazon {
	
	const property position = game.at(2,23)
	
}


object corazon4 inherits Corazon {
	
	const property position = game.at(3,23)
	
}



object corazon5 inherits Corazon {
	
	const property position = game.at(4,23)
	
}

object proyectil {

    var property position = personaje.position()

    method image() = "bolaFuego.png"

    method trayectoria() {


		position = game.at(position.x()+1, y)
    }

        game.onTick(1000, "Movimiento proyectil", )
}