 import wollok.game.*


object arriba {
	method siguientePosicion(pos) = if (pos.up(1).y() > 22) game.at(pos.x(), 22) else pos.up(1) 	
}
object derecha {
	method siguientePosicion(pos) = if (pos.right(1).x() > 24) game.at(24, pos.y()) else pos.right(1) 	
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

		const x = 1.randomUpTo(game.width())
		const y = 1.randomUpTo(game.height())

		// cambio a nueva posicion
		return game.at(x, self.coordenadaEnY(y))
	}
	
	method coordenadaEnY(unaPosicion) {
		
		if (unaPosicion%2 == 0) 
			return unaPosicion
		else
			return unaPosicion + 1
		
	}

}