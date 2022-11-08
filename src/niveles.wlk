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
		nivel_1.configuracionInicial()
		game.schedule(3500, {teclado.configurarTeclas()})
		game.schedule(3520, {juego.crearBordes()
							personaje.agregarVida()}
		)
	}
}

class Nivel{
	var property oleada1
	var property oleada2
	var property oleada3
	var property elementosEspeciales
	const property musica
	const property siguienteNivel
	var tiempoOleada2
	var tiempoOleada3
	const imagenIntro
	const fondoNivel

	
	method puntosAConseguir() = oleada1.size() + oleada2.size() + oleada3.size()
	
	method configuracionInicial(){
		game.addVisual(imagenIntro)
		musica.play()
		
		game.schedule(3500, {game.removeVisual(imagenIntro)
							game.addVisual(fondoNivel)
							self.agregarElementosEspeciales()}
		)
		game.schedule(3600, {personaje.configuracionInicial()
							self.configuracionOleadaEnemigos()}
		)
	}

	method configuracionOleadaEnemigos() {

		oleada1.forEach{unEnemigo => unEnemigo.agregarse()}
		game.schedule(tiempoOleada2, {oleada2.forEach{unEnemigo=> unEnemigo.agregarse()}})
		game.schedule(tiempoOleada3, {oleada3.forEach{unEnemigo=> unEnemigo.agregarse()}})
	}

	method agregarElementosEspeciales() {
		
		elementosEspeciales.forEach{unElemento => unElemento.agregarse()}
	}	

	method eliminarTodo() {

		musica.stop()
		game.removeVisual(fondoNivel)
		game.removeVisual(personaje)
		game.removeVisual(minaInventario)
		elementosEspeciales.forEach({unElemento=>unElemento.sacaloSiEsta()})
		siguienteNivel.configuracionInicial()
	}

	method perder(){
		musica.stop()
		gameOver.finalizarJuego()
	}

}
/******** INSTANCIAS DE NIVELES **********/
const nivel_1 =
	new Nivel(
			oleada1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta)],
 			oleada2 = [new Enemigo(especie = zombieBeta, position = game.at(14, 2)), new Enemigo(especie= zombieAlfa, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 5), especie = zombieAlfa), new Enemigo(position = game.at(14, 3), especie = zombieBeta)],			
			oleada3 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 6)), new Enemigo(especie= zombieAlfa, position = game.at(15, 4)), new Enemigo(position = game.at(15, 10), especie = zombieAlfa), new Enemigo (position = game.at(14, 8), especie = zombieAlfa), new Enemigo(position = game.at(14, 5), especie = zombieBeta)],
			elementosEspeciales = [mina, balaChetada],
			musica = music1,
			siguienteNivel = nivel_2,
			tiempoOleada2 = 10000,
			tiempoOleada3 = 17000,
			imagenIntro = fondoIntroNivel_1,
			fondoNivel = fondoNivel_1
			)

const nivel_2 =
	new Nivel(
			oleada1 = [new Enemigo(especie = zombieEsqueleto, position = game.at(14, 3)), new Enemigo(especie= zombieEsqueletoHalloween, position = game.at(15, 6)), new Enemigo(position = game.at(15, 8), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 9), especie = zombieEsqueleto), new Enemigo(position = game.at(14,2), especie = zombieEsqueletoHalloween)],
 			oleada2 = [new Enemigo(especie = zombieEsqueleto, position = game.at(14, 2)), new Enemigo(especie= zombieEsqueletoBalde, position = game.at(15, 5)), new Enemigo(position = game.at(15, 7), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 8), especie = zombieEsqueletoHalloween), new Enemigo(position = game.at(14,9), especie = zombieEsqueletoHalloween)],
			oleada3 = [new Enemigo(especie = zombieEsqueletoBalde, position = game.at(14, 3)), new Enemigo(especie= zombieEsqueletoHalloween, position = game.at(15, 6)), new Enemigo(position = game.at(15, 8), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 4), especie = zombieEsqueletoBalde), new Enemigo(position = game.at(14, 9), especie = zombieEsqueletoBalde), new Enemigo(position = game.at(14,5), especie = zombieEsqueletoHalloween)],
			elementosEspeciales = [mina,curita, balaInfinito],
			musica = music2,
			siguienteNivel = nivel_3,
			tiempoOleada2 = 15000,
			tiempoOleada3 = 25000,
			imagenIntro = fondoIntroNivel_2,
			fondoNivel = fondoNivel_2
			)

const nivel_3 =
	new Nivel(
			oleada1 = [new Enemigo(especie = zombieAlfa, position = game.at(14, 2)), new Enemigo(especie= zombieBeta, position = game.at(15, 5)), new Enemigo(position = game.at(15, 8), especie = zombieBeta), new Enemigo (position = game.at(14, 4), especie = zombieBeta), new Enemigo(position = game.at(14, 9), especie = zombieBeta), new Enemigo(position = game.at(14, 6), especie = zombieAlfa)],
 			oleada2 = [new Enemigo(especie = zombieEsqueletoBalde, position = game.at(14, 2)), new Enemigo(especie= zombieEsqueleto, position = game.at(15, 9)), new Enemigo(position = game.at(15, 10), especie = zombieEsqueletoHalloween), new Enemigo (position = game.at(14, 5), especie = zombieEsqueleto), new Enemigo(position = game.at(14, 3), especie = zombieEsqueletoHalloween), new Enemigo(position = game.at(14, 2), especie = zombieEsqueletoBalde)],
			oleada3 = [boss],
			elementosEspeciales = [mina,curita],
			musica = music3,
			siguienteNivel = finDelJuego,
			tiempoOleada2 = 15000,
			tiempoOleada3 = 20000,
			imagenIntro = fondoIntroNivel_3,
			fondoNivel = fondoNivel_3
			)


object finDelJuego{
	
	method configuracionInicial(){
		game.say(personaje, "Ganaste!")
		game.schedule(1500, {=> juego.ganar()})
	}

}


	
