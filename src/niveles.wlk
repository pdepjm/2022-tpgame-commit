import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*
import texto.*


object primerNivel {
	
	const enemigos1 = [new Enemigo(vida = 3, velocidad = 1000, position = game.at(26, 10), image = "zombieAlfa.png"), new Enemigo(vida = 2, velocidad = 1500, position = game.at(27, 12), image = "zombie.png"), new Enemigo(position = game.at(27, 14), vida = 2, velocidad = 1500, image = "zombie.png"), new Enemigo (position = game.at(26, 16), vida = 3, velocidad = 1000, image = "zombieAlfa.png"), new Enemigo(position = game.at(26, 18), vida = 2, velocidad = 1500, image = "zombie.png")]
	const enemigos2 = [new Enemigo(vida = 2, velocidad = 1000, position = game.at(26, 8), image = "zombie.png"), new Enemigo(vida = 3, velocidad = 1000, position = game.at(27, 10), image = "zombieAlfa.png"), new Enemigo(position = game.at(27, 14), vida = 3, velocidad = 1000, image = "zombieAlfa.png"), new Enemigo (position = game.at(26, 18), vida = 3, velocidad = 1000, image = "zombieAlfa.png"), new Enemigo(position = game.at(26, 20), vida = 2, velocidad = 1500, image = "zombie.png")]	
	const enemigos3 = [new Enemigo(vida = 3, velocidad = 1000, position = game.at(26, 6), image = "zombieAlfa.png"), new Enemigo(vida = 3, velocidad = 1000, position = game.at(27, 10), image = "zombieAlfa.png"), new Enemigo(position = game.at(27, 14), vida = 2, velocidad = 1500, image = "zombieAlfa.png"), new Enemigo (position = game.at(26, 16), vida = 3, velocidad = 1000, image = "zombieAlfa.png"), new Enemigo(position = game.at(26, 22), vida = 2, velocidad = 1500, image = "zombie.png")]	
	const bordes = []
	
	method configuracionInicial(){
		game.boardGround("grass00.png")
		music1.play()
		self.configuracionOleadaEnemigos() 
		personaje.configurarAcciones()
		self.agregarElementosEspeciales() 
		
	}

	method configuracionOleadaEnemigos() {
		enemigos1.forEach{enemigo=> enemigo.agregarse()}
		game.schedule(15000, {enemigos2.forEach{enemigo=> enemigo.agregarse()}})
		game.schedule(25000, {enemigos3.forEach{enemigo=> enemigo.agregarse()}})
	}
	
	method agregarElementosEspeciales() {
		curita.agregarse() 
		relojDeArena.agregarse() 
		imagenDelContador.agregarse()
		textoDelContador.agregarse()
		generacionBordes.crearBordesIzquierdosEn(bordes) 
		bordes.forEach{unBorde=> unBorde.agregarse()}
	}			
}


object segundoNivel {
	
}



	
