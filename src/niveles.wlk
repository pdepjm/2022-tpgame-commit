import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*
import texto.*


object primerNivel {
	
	const Enemigos1 = [new Enemigo(vida = 3, velocidad = 1000, position = game.at(26, 10), image = "zombieAlfa.png"), new Enemigo(vida = 2, velocidad = 1500, position = game.at(27, 12), image = "zombie.png"), new Enemigo(position = game.at(27, 14), vida = 2, velocidad = 1500, image = "zombie.png"), new Enemigo (position = game.at(26, 16), vida = 3, velocidad = 1000, image = "zombieAlfa.png"), new Enemigo(position = game.at(26, 18), vida = 2, velocidad = 1500, image = "zombie.png")]
	const Enemigos2 = [new Enemigo (position = game.at(22, 8)), new Enemigo (position = game.at(22, 12)), new Enemigo(position = game.at(22, 14)), new Enemigo (position = game.at(22, 18)), new Enemigo(position = game.at(22, 20))]
	const Enemigos3 = [new Enemigo (position = game.at(22, 6)), new Enemigo (position = game.at(22, 14)), new Enemigo (position = game.at(22, 16)), new Enemigo (position = game.at(22, 12)), new Enemigo(position = game.at(22, 18))]
	const bordes = []
	
	method configuracionInicial(){
		game.boardGround("grass00.png")
		music1.play()
		self.configuracionOleadaEnemigos() 
		personaje.configurarAcciones()
		self.agregarElementosEspeciales() 
		
	}

	method configuracionOleadaEnemigos() {
		Enemigos1.forEach{Enemigo=> Enemigo.agregarse()}
		game.schedule(15000, {Enemigos2.forEach{Enemigo=> Enemigo.agregarse()}})
		game.schedule(25000, {Enemigos3.forEach{Enemigo=> Enemigo.agregarse()}})
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



	
