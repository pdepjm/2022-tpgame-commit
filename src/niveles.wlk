import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*
import texto.*


object primerNivel {
	
	const zombies1 = [new ZombieAlfa(position = game.at(26, 10)), new Zombie(position = game.at(27, 12)), new Zombie(position = game.at(27, 14)), new ZombieAlfa(position = game.at(26, 16)), new Zombie(position = game.at(26, 18))]
	const zombies2 = [new ZombieAlfa(position = game.at(22, 8)), new ZombieAlfa(position = game.at(22, 12)), new Zombie(position = game.at(22, 14)), new ZombieAlfa(position = game.at(22, 18)), new Zombie(position = game.at(22, 20))]
	const zombies3 = [new ZombieAlfa(position = game.at(22, 6)), new ZombieAlfa(position = game.at(22, 14)), new ZombieAlfa(position = game.at(22, 16)), new ZombieAlfa(position = game.at(22, 12)), new Zombie(position = game.at(22, 18))]
	const bordes = []
	
	method configuracionInicial(){
		game.boardGround("grass00.png")
		music1.play()
		self.configuracionOleadaZombies() 
		personaje.configurarAcciones()
		self.agregarElementosEspeciales() 
		
	}

	method configuracionOleadaZombies() {
		zombies1.forEach{zombie=> zombie.agregarse()}
		game.schedule(15000, {zombies2.forEach{zombie=> zombie.agregarse()}})
		game.schedule(25000, {zombies3.forEach{zombie=> zombie.agregarse()}})
	}
	
	method agregarElementosEspeciales() {
		curita.agregarse() 
		relojDeArena.agregarse() 
		imagenDelContador.agregarse()
		textoDelContador.agregarse()
		generacionBordes.crearBordesIzquierdos(bordes) 
		bordes.forEach{unBorde=> unBorde.agregarse()}
	}			
}


object segundoNivel {
	
}



	
