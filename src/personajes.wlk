 import wollok.game.*
import direcciones.* 


object personaje {

    var property vida = [corazon1, corazon2, corazon3, corazon4, corazon5]

    var position = game.center()

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)
	}
	
	method perderVida() { 
		game.removeVisual(vida.last())
		vida.remove(vida.last())
		if(vida.size() == 0)
		{
			game.addVisual(fin)
		}
	}
}


object fin {
	
	method position() = game.center()
	
	method image() = "gameover.png"
}


class Corazon {
    
    //method image() = "corazon.jpg"
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


object zombieFalopa {
	
	method position() = game.at(1,12)
	
	method image() = "zombie.png"
	
}
















class Enemigo {
    var vida 
    const danio
    
       
}




class Zombie inherits Enemigo {
    

   


}


class Esqueleto inherits Enemigo {


}









