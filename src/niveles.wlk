import wollok.game.*
import direcciones.* 
import juego.*
import personajePrincipal.*
import inventarioPersonaje.*
import elementosJuego.*
import texto.*
import enemigos.*




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
		game.schedule(5100, {juego.agregarPersonajes()})
		game.schedule(5000, {=>nivel_1.configuracionInicial()})
	}
}


object nivel_1 {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)]																							
	const property musica = music1
	const bordes = []
	
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size()
	
	method configuracionInicial(){
		game.removeVisual(fondoIntroNivel_1)
		music1.play()
		game.schedule(100,{=>self.configuracionInicial2()})
		
		
	}
	
	method configuracionInicial2(){
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
		music1.stop()
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
	const property musica = music2
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + enemigos3.size() 
	
	method configuracionInicial() {
		game.removeVisual(fondoIntroNivel_2)
		game.addVisual(fondoNivel_2)
		game.removeVisual(personaje)
		game.addVisual(personaje)
		personaje.aumentarTodaLaVida()
		personaje.renovarCargador()
		music2.play()
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
		music2.stop()
		game.schedule(1000, {=>game.addVisual(fondoIntroNivel_3)})
		game.schedule(5000, {=>nivel_3.configuracionInicial()})
		game.schedule(1000, {=>mina.sacaloSiEsta()})
	}	
	
	method siguienteNivel() = nivel_3
}

object nivel_3 {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta), new Enemigo(position = game.at(14, 6), especie = zombieAlfa)]
	const enemigos2 = [new Enemigo(especie = zombieEsqueletoBalde, position = game.at(14, 2)), new Enemigo(especie= zombieEsqueleto, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 5), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 3), especie = zombieEsqueletoHalloween), new Enemigo(position = game.at(14, 2), especie = zombieEsqueletoBalde)]
	const property musica = music3
	method puntosAConseguir() = enemigos1.size() + enemigos2.size() + 1
	
	method configuracionInicial() {
		game.removeVisual(fondoIntroNivel_3)
		game.removeVisual(fondoNivel_2)
		game.addVisual(fondoNivel_3)
		game.removeVisual(personaje)
		game.addVisual(personaje)
		music3.play()
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
		game.schedule(1500, {=> juego.ganar()})
	}

}


	
