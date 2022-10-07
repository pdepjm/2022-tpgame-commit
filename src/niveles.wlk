import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object inicio {

	method configuracionInicial(){
		game.addVisual("inicio.jpeg")
		keyboard.e().onPressDo({primerNivel.configuracionInicial()})
	}
}

object primerNivel {
	const zombies = [new ZombieAlfa(position = game.at(22, 10)), new ZombieAlfa(position = game.at(22, 10)), new ZombieAlfa(position = game.at(22, 10)), new ZombieAlfa(position = game.at(22, 10)), new ZombieAlfa(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 10)), new ZombieBeta(position = game.at(22, 12)), new ZombieBeta(position = game.at(22, 14)), new ZombieBeta(position = game.at(22, 16)), new ZombieBeta(position = game.at(22, 18))] 
	// 5 alfas y 10 betas
	method configuracionInicial(){
		game.removeVisual("inicio.jpeg")
		juego.agregarPersonajes()
		juego.configurarTeclasNiveles()
		game.boardGround("grass00.png")
		music1.play()
		zombies.forEach{zombie=> zombie.agregarse()}
		personaje.vida().forEach{corazon => corazon.agregarse()}
		imagenDelContador.agregarse()
		contadorDeBalas.agregarse()
	}
					
}


object segundoNivel {
	
}


object tercerNivel {
	
}