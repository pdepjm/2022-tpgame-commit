 import wollok.game.*
 import personajePrincipal.*

object teclado {
	
	method configurarTeclas() {
		keyboard.up().onPressDo({personaje.moverA(arriba)})
		keyboard.right().onPressDo({personaje.moverA(derecha)})
		keyboard.left().onPressDo({personaje.moverA(izquierda)})  
		keyboard.down().onPressDo({personaje.moverA(abajo)}) 
		keyboard.space().onPressDo({personaje.disparar()})
		keyboard.r().onPressDo({personaje.recargarBalas()})
		
	}
}

object arriba {
	method siguientePosicion(pos) = if (pos.up(1).y() > 10) game.at(pos.x(), 10) else pos.up(1)
}
object derecha {
	method siguientePosicion(pos) = if (pos.right(1).x() > 11) game.at(11, pos.y()) else pos.right(1)
}
object izquierda {
	method siguientePosicion(pos) = if (pos.left(1).x() < 1) game.at(1,pos.y()) else pos.left(1)
}
object abajo {
	method siguientePosicion(pos) = if (pos.down(1).y() < 1) game.at(pos.x(), 1) else pos.down(1)
}


object aleatorio {

	method dondeAparecer() {
		
		// calculo coordenadas aleatorias dentro la pantalla

		const x = 3.randomUpTo(11).roundUp()
		const y = 3.randomUpTo(10).roundUp()

		// cambio a nueva posicion
		return game.at(x, y)
	}
	

}