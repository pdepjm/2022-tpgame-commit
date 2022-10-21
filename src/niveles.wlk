import wollok.game.*
import direcciones.* 
import juego.*
import personaje.*
import enemigos.*
import elementosJuego.*
import texto.*


class Nivel {

	method configuracionInicial() 

	method configuracionOleadaEnemigos() 

	method agregarElementosEspeciales()
}


object primerNivel {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(26, 10)), new Enemigo(especie= zombieBeta, position = game.at(27, 12)), new Enemigo(position = game.at(27, 14), especie = zombieBeta), new Enemigo (position = game.at(26, 16), especie = zombieBeta), new Enemigo(position = game.at(26, 18), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(26, 8)), new Enemigo(especie= zombieAlfa, position = game.at(27, 10)), new Enemigo(position = game.at(27, 14), especie = zombieAlfa), new Enemigo (position = game.at(26, 18), especie = zombieAlfa), new Enemigo(position = game.at(26, 20), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(26, 6)), new Enemigo(especie= zombieAlfa, position = game.at(27, 10)), new Enemigo(position = game.at(27, 14), especie = zombieAlfa), new Enemigo (position = game.at(26, 16), especie = zombieAlfa), new Enemigo(position = game.at(26, 22), especie = zombieBeta)]																							
	const boss2 = enemigoBoss
	const bordes = []

	
	method configuracionInicial(){
		game.boardGround("grass00.png")
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
		game.schedule(500, {boss2.agregarse()})
		game.onTick(500, "BolaBoss", {boss2.especie().dispararPersonaje()})
	}
	
	method agregarElementosEspeciales() {
		curita.agregarse() 
		relojDeArena.agregarse() 
		imagenDelContador.agregarse()
		textoDelContador.agregarse()
		generacionBordes.crearBordesIzquierdosEn(bordes) 
		bordes.forEach{unBorde=> unBorde.agregarse()}
		mina.agregarse()
	}			
}


object segundoNivel {
	
}

object tercerNivel {
	
}


	
