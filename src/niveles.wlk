import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object primerNivel {
	const zombies = [new Zombie(position = game.at(23, 12)), new Zombie(position = game.at(22, 13)), new Zombie(position = game.at(22, 14)), new Zombie(position = game.at(22, 15)), new Zombie(position = game.at(22, 16))] 

	method configuracionInicial(){
	
	
	zombies.forEach({zombie=> zombie.agregarse()})
	
	}
					
}
