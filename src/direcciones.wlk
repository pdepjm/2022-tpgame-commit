 import wollok.game.*


object arriba {
	method siguientePosicion(pos) = pos.up(1) 	
}
object derecha {
	method siguientePosicion(pos) = pos.right(1) 	
}
object izquierda {
	method siguientePosicion(pos) = pos.left(1) 	
}
object abajo {
	method siguientePosicion(pos) = pos.down(1) 	
}

object aleatorio {

	method dondeAparecer() {
		
		// calculo coordenadas aleatorias dentro la pantalla

		const x = 0.randomUpTo(game.width())
		const y = 0.randomUpTo(game.height())

		// cambio a nueva posicion
		return game.at(x, y)
	}

}