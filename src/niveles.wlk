import wollok.game.*
import direcciones.* 
import juego.*
import personajePrincipal.*
import inventarioPersonaje.*
import elementosJuego.*
import texto.*
import enemigos.*


const fondoIntroNivel_0 = new Visual (image = "fondo.png", position = game.at(0,0))
const fondoIntroNivel_1 = new Visual (image = "LEVEL1.png", position = game.at(0,0))
const fondoIntroNivel_2 = new Visual (image = "LEVEL2.png", position = game.at(0,0))
const fondoIntroNivel_3 = new Visual (image = "LEVEL3.png", position = game.at(0,0))
const fondoNivel_1 = "grass00.png"
const fondoNivel_2 = new Visual(image = "lava.jpg", position = game.at(1,0))
const fondoNivel_3 = new Visual (image = "lava.jpg", position = game.at(1,0))
const finDeJuego = new Visual (image = "FIN.png", position = game.at(0,0))

object nivel_0 {
	var siguienteNivelConfigurado = false
		
	method configuracionInicial(){
		game.boardGround(fondoNivel_1)
		game.addVisual(fondoIntroNivel_0)
		keyboard.e().onPressDo{self.iniciarJuego()}
	}
	
	method iniciarJuego() {
		if (!siguienteNivelConfigurado) { 
			siguienteNivelConfigurado = true
			self.configurarSiguienteNivel()
		} else {}
	}
	
	method configurarSiguienteNivel() {
		game.removeVisual(fondoIntroNivel_0)
		game.addVisual(fondoIntroNivel_1)
		game.schedule(4900, {juego.agregarPersonajes()})
		game.schedule(5000, {=>nivel_1.configuracionInicial()})
	}
}


object nivel_1 {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)]																							

	const bordes = []
	
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size()
	
	method configuracionInicial(){
		game.removeVisual(fondoIntroNivel_1)
		music1.play()
		personaje.configurarAcciones()
		generacionBordes.crearBordesIzquierdos(bordes) 
		self.configuracionOleadaEnemigos() 
		self.agregarElementosEspeciales() 
		
	}

	method configuracionOleadaEnemigos() {
		enemigos1.forEach{unEnemigo=> unEnemigo.agregarse()}
		game.schedule(10000, {enemigos2.forEach{unEnemigo=> unEnemigo.agregarse()}})
		game.schedule(17000, {enemigos3.forEach{unEnemigo=> unEnemigo.agregarse()}})
	}
	
	method agregarElementosEspeciales() {
		
		bordes.forEach{unBorde=> unBorde.agregarse()}
		mina.agregarse()
		balaChetada.agregarse() 
	}		

	method configurarSiguienteNivel() {
		game.schedule(1000, {=>game.addVisual(fondoIntroNivel_2)})
		game.schedule(5000, {=>nivel_2.configuracionInicial()})
		game.schedule(1000, {=>mina.sacaloSiEsta()})
	}	
	
	method siguienteNivel() = nivel_2
}


object nivel_2 {
	
	const enemigos1 = [new Enemigo(especie = zombieEsqueleto, position = game.at(14, 3)), new Enemigo(especie= zombieEsqueletoHalloween, position = game.at(15, 6)), new Enemigo(position = game.at(15, 8), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 9), especie = zombieEsqueleto), new Enemigo(position = game.at(14,2), especie = zombieEsqueletoHalloween)]
	const enemigos2 = [new Enemigo(especie = zombieEsqueleto, position = game.at(14, 2)), new Enemigo(especie= zombieEsqueletoBalde, position = game.at(15, 5)), new Enemigo(position = game.at(15, 7), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 8), especie = zombieEsqueletoHalloween), new Enemigo(position = game.at(14,9), especie = zombieEsqueletoHalloween)]
	const enemigos3 = [new Enemigo(especie = zombieEsqueletoBalde, position = game.at(14, 3)), new Enemigo(especie= zombieEsqueletoHalloween, position = game.at(15, 6)), new Enemigo(position = game.at(15, 8), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueletoBalde), new Enemigo(position = game.at(14, 9), especie = zombieEsqueletoBalde), new Enemigo(position = game.at(14,5), especie = zombieEsqueletoHalloween)]

		
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size() 
	
	method configuracionInicial() {
		game.removeVisual(fondoIntroNivel_2)
		game.addVisual(fondoNivel_2)
		game.removeVisual(personaje)
		game.addVisual(personaje)
		personaje.aumentarTodaLaVida()
		personaje.renovarCargador()

		//music1.play()
		self.configuracionOleadaEnemigos() 
		self.agregarElementosEspeciales() 
	}
	
	method configuracionOleadaEnemigos() {
		enemigos1.forEach{unEnemigo=> unEnemigo.agregarse()}
		game.schedule(15000, {enemigos2.forEach{unEnemigo=> unEnemigo.agregarse()}})
		game.schedule(25000, {enemigos3.forEach{unEnemigo=> unEnemigo.agregarse()}})
	}
	
	method agregarElementosEspeciales() {
		
		curita.agregarse() 
		mina.agregarse()
		balaInfinito.agregarse() 
	}		

	method configurarSiguienteNivel() {
		game.schedule(1000, {=>game.addVisual(fondoIntroNivel_3)})
		game.schedule(5000, {=>nivel_3.configuracionInicial()})
		game.schedule(1000, {=>mina.sacaloSiEsta()})
	}	
	
	method siguienteNivel() = nivel_3
}

object nivel_3 {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta), new Enemigo(position = game.at(14, 6), especie = zombieAlfa)]
	const enemigos2 = [new Enemigo(especie = zombieEsqueletoBalde, position = game.at(14, 2)), new Enemigo(especie= zombieEsqueleto, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 5), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 3), especie = zombieEsqueletoHalloween), new Enemigo(position = game.at(14, 6), especie = zombieEsqueletoBalde)]

	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + 1
	
	method configuracionInicial() {
		game.removeVisual(fondoIntroNivel_3)
		game.removeVisual(fondoNivel_2)
		game.addVisual(fondoNivel_3)
		game.removeVisual(personaje)
		game.addVisual(personaje)
		
		//music1.play()
		self.configuracionOleadaEnemigos() 
		self.agregarElementosEspeciales()
		personaje.aumentarTodaLaVida()
		personaje.renovarCargador() 
		game.schedule(1000, {=>mina.sacaloSiEsta()})
		
	}
	
	method configuracionOleadaEnemigos() {
		enemigos1.forEach{unEnemigo=> unEnemigo.agregarse()}
		game.schedule(15000, {enemigos2.forEach{unEnemigo=> unEnemigo.agregarse()}})
		game.schedule(20000, {boss.agregarse()})
		game.onTick(1500, "BolaBoss", {boss.dispararPersonaje()})
	}
	
	method agregarElementosEspeciales() {
		curita.agregarse()
		mina.agregarse()
	}		
	
	method configurarSiguienteNivel(){
		self.siguienteNivel().configuracionInicial() 
	}
	
	method siguienteNivel() = nivel_4
	
}

object nivel_4{
	
	method configuracionInicial(){
		game.say(personaje, "Ganaste!")
		game.schedule(1500, {=> game.addVisual(finDeJuego)})
	}
	
}


	
