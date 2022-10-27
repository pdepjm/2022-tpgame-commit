import wollok.game.*
import direcciones.* 
import juego.*
import personajePrincipal.*
import inventarioPersonaje.*
import elementosJuego.*
import enemigos.*

object inicio {
	var siguienteNivelConfigurado = false
		
	method configuracionInicial(){
		
		game.addVisual(fondoIntroNivel_0)
		keyboard.e().onPressDo{self.iniciarJuego()}
	}
	
	method iniciarJuego() {
		if (!siguienteNivelConfigurado) { 
			siguienteNivelConfigurado = true
			self.configurarInicioJuego()
		} else {}
	}
	
	method configurarInicioJuego() {
		game.removeVisual(fondoIntroNivel_0)
		//game.addVisual(fondoIntroNivel_1)
		//music1.play()
		game.schedule(5100, {juego.configuracionTeclado()})
		game.schedule(5100, {personaje.configurarAcciones()})
		game.schedule(5000, {nivel_1.configuracionInicial()})

	}
}

class Nivel{
	var property oleada1
	var property oleada2
	var property oleada3
	var property elementosEspeciales
	const property musica
	const imagenIntro
	const fondoNivel
	const bordes = []

	
	method puntosAConseguir() = oleada1.size() + oleada2.size() + oleada3.size()
	
	method configuracionInicial() {
		game.addVisual(imagenIntro)
		game.schedule(1000, game.removeVisual(imagenIntro))
		game.schedule
		
	}


}

object nivel_1 {
	
	const enemigos1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)]
	const enemigos2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)]
	const enemigos3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)]																							
	const property musica = music1
	const bordes = []
	
	
	
	method configuracionInicial(){
		game.removeVisual(fondoIntroNivel_1)
		game.schedule(100,{self.configuracionInicial2()})
	}
	
	method configuracionInicial2(){
		generacionBordes.crearBordes(bordes) 
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
		game.schedule(1000, {=>music2.play()})
		game.schedule(1000, {=>game.addVisual(fondoIntroNivel_2)})
		game.schedule(5000, {=>nivel_2.configuracionInicial()})
		game.schedule(1000, {=>mina.sacaloSiEsta()})
	}	
	
	method siguienteNivel() = nivel_2
	
	method perder(){
		musica.stop()
		gameOver.finalizarJuego()
	}
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
		game.schedule(1000, {=>music3.play()})
		game.schedule(1000, {=>game.addVisual(fondoIntroNivel_3)})
		game.schedule(5000, {=>nivel_3.configuracionInicial()})
		game.schedule(1000, {=>mina.sacaloSiEsta()})
	}	
	
	method siguienteNivel() = nivel_3
	
	method perder(){
		musica.stop()
		gameOver.finalizarJuego()
	}
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
	
	method siguienteNivel() = finDelJuego 
	
	method perder(){
		musica.stop()
		game.removeTickEvent("BolaBoss")
		gameOver.finalizarJuego()
	}
	
}

object finDelJuego{
	
	method configuracionInicial(){
	    
		game.say(personaje, "Ganaste!")
		game.schedule(1500, {=> juego.ganar()})
	}

}


	
