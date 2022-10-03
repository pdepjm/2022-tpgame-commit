 import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*


object personaje {

    var property vida = [corazon1, corazon2, corazon3, corazon4, corazon5]

    var property position = game.center()

    method position() = position

    method image() = "personaje.png"

    method moverA(direccion) {
		position = direccion.siguientePosicion(position)
	}
	
	method perderVida() {
		hitSound.play()
		game.removeVisual(vida.last())
		vida.remove(vida.last())
		if(vida.size() == 0)
		{
			game.addVisual(fin)
		}
	}

	method disparar() {
		
		const hola = new Proyectil()
		
		game.addVisual(hola)
		
		hola.trayectoria()
	}
	
	method morir() { }
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
	
	method hacerDanio(personaje) {
		personaje.perderVida()
	}
	
	method morir() {
		game.removeVisual(self)
	}
	
}

<<<<<<< HEAD
=======
class Enemigo {
    var vida 
    const danio
    
       
}
>>>>>>> 2f50b6d8d378595a956deae7a406562a135d3aba




<<<<<<< HEAD









=======
class Zombie inherits Enemigo {
    

   


}


class Esqueleto inherits Enemigo {


}
>>>>>>> 2f50b6d8d378595a956deae7a406562a135d3aba









