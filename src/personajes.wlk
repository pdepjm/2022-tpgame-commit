import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*


object personaje {

    var property vida = [corazon1, corazon2, corazon3, corazon4, corazon5]

    var property position = game.center()

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)
	}
	
	method perderVida() {
		//game.onTick(10, "Sonido de steve", {hitSound.play()})
		hitSound.play()
		game.removeVisual(vida.last())
		vida.remove(vida.last())

		if(vida.size() == 0)
		{
			game.addVisual(fin)
		}
	}

	method disparar() {
		const proyectil = new Proyectil()
		
		game.addVisual(proyectil)
		
		proyectil.trayectoria()
		

	} 
}


object zombie1 {
	
	var property position = game.at(23, 12)
	
	var x = 23
	const y = 12

	method image() = "zombie.png"

	method moverse() {
		x -= 1
		position = game.at(x, y)
	}
	
}

class Enemigo {
    var vida 
    const danio
    
       
}




class Zombie inherits Enemigo {
    

   


}


class Esqueleto inherits Enemigo {


}









