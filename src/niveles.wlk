import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object inicio {

	method configuracionInicial(){
	game.boardGround("inicio.jpeg")
	keyboard.e().onPressDo({nivel1.configuracionInicial()} )
	}
}

object primerNivel {
	const zombies = [new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 12)), new ZombieBeta(position = game.at(22, 14)), new ZombieBeta(position = game.at(22, 16)), new ZombieBeta(position = game.at(22, 18))] 
	
	method configuracionInicial(){
		juego.agregarPersonajes()
		juego.configurarTeclasNiveles()
		game.boardGround("grass00.png")
		music1.play()
		zombies.forEach{zombie=> zombie.agregarse()}
		personaje.vida().forEach{corazon => corazon.agregarse()}
		personaje.bolasDeFuego().forEach{bola => bola.agregarse()}
	}
					
}


object segundoNivel {
	
}


object tercerNivel {
	
}