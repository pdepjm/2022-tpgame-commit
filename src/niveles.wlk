import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object primerNivel {
	const zombies = [new Zombie(position = game.at(22, 10)), new Zombie(position = game.at(22, 12)), new Zombie(position = game.at(22, 14)), new Zombie(position = game.at(22, 16)), new Zombie(position = game.at(22, 18)), new ZombieAlfa(position=game.at(22,19))] 
	
	method configuracionInicial(){
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