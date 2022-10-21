import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*
import texto.*

const fondoIntro = new Visual (image = "inicio.jpeg" ,position=game.at(0,0))

object nivel0 {
	
		
	method configuracionInicial(){
		game.boardGround("grass00.png")
		game.addVisual(fondoIntro)
		keyboard.e().onPressDo({primerNivel.configuracionInicial()} )
	}
}


object primerNivel {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)]																							
	//const boss2 = enemigoBoss
	const bordes = []

	
	method configuracionInicial(){
		game.removeVisual(fondoIntro)
		barraVisual.agregarse()
		music1.play()
		self.configuracionOleadaEnemigos() 
		personaje.configurarAcciones()
		self.agregarElementosEspeciales() 
		
	}

	method configuracionOleadaEnemigos() {
		enemigos1.forEach{enemigo=> enemigo.agregarse()}
		game.schedule(15000, {enemigos2.forEach{enemigo=> enemigo.agregarse()}})
		game.schedule(25000, {enemigos3.forEach{enemigo=> enemigo.agregarse()}})
		//game.schedule(500, {boss2.agregarse()})
		//game.onTick(500, "BolaBoss", {boss2.especie().dispararPersonaje()})
	}
	
	method agregarElementosEspeciales() {
		curita.agregarse() 
		relojDeArena.agregarse() 
		imagenDelContador.agregarse()
		//textoDelContador.agregarse()
		generacionBordes.crearBordesIzquierdosEn(bordes) 
		bordes.forEach{unBorde=> unBorde.agregarse()}
		mina.agregarse()
	}			
}


object segundoNivel {
	
}

object tercerNivel {
	
}


	
