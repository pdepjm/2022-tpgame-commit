 import wollok.game.*

object arriba {
	method siguientePosicion(pos) = if (pos.up(1).y() > 22) game.at(pos.x(), 22) else pos
}
object derecha {
	method siguientePosicion(pos) = if (pos.right(1).x() > 24) game.at(24, pos.y()) else pos	
}
object izquierda {
	method siguientePosicion(pos) = if (pos.left(1).x() < 1) game.at(1,pos.y()) else pos
}
object abajo {
	method siguientePosicion(pos) = if (pos.down(1).y() < 1) game.at(pos.x(), 1) else pos	
}


object aleatorio {

	method dondeAparecer() {
		
		// calculo coordenadas aleatorias dentro la pantalla

		const x = 2.randomUpTo(game.width()).roundUp()
		const y = 2.randomUpTo(game.height()).roundUp()

		// cambio a nueva posicion
		return game.at(x, y)
	}
	

}