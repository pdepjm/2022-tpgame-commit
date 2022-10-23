import wollok.game.*
import direcciones.* 
import juego.*
import personajePrincipal.*
import elementosJuego.*
import texto.*
import enemigos.*


const fondoIntro = new Visual (image = "fondoIntro.jpg", position = game.at(0,0))
const fondoIntroNivel_2 = new Visual (image = "LEVEL2.png", position = game.at(0,0))
const fondoNivel_2 = new Visual(image = "fondoAgua.png", position = game.at(1,0))

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

	const bordes = []
	
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size()

	//const boss2 = enemigoBoss

	
	method configuracionInicial(){
		game.removeVisual(fondoIntro)
		barraVisual.agregarse()
		music1.play()
		generacionBordes.crearBordesIzquierdos(bordes) 
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
		
		bordes.forEach{unBorde=> unBorde.agregarse()}
		imagenDelContador.agregarse()
		//textoDelContador.agregarse()
		curita.agregarse() 
		//relojDeArena.agregarse()
		balaChetada.agregarse() 
		mina.agregarse()
	}		

	method configurarSiguienteNivel() {
		game.addVisual(fondoIntroNivel_2)
		segundoNivel.configuracionInicial()
	}	
	
	method siguienteNivel() = segundoNivel
}


object segundoNivel {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)]																							
	
	const bordes = []
	
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size() 
	
	method configuracionInicial() {
		game.removeVisual(fondoIntroNivel_2)
		game.addVisual(fondoNivel_2)
		game.removeVisual(personaje)
		game.addVisualCharacter(personaje)
		
	}
}

object tercerNivel {
	
}


	
