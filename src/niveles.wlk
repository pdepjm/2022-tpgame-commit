import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object primerNivel {
	const zombies = [new Zombie(position = game.at(22, 10)), new Zombie(position = game.at(22, 12)), new Zombie(position = game.at(22, 14)), new Zombie(position = game.at(22, 16)), new Zombie(position = game.at(22, 18))] 

	method configuracionInicial(){
	
	
		zombies.forEach({zombie=> zombie.agregarse()})
	
	}
					
}
