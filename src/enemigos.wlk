import wollok.game.*
import direcciones.* 
import juego.*
import elementosJuego.*
import niveles.*
import personajePrincipal.*


class Enemigo {
	
	var property position
	var property especie
	var property vida = especie.vida()
	var property image = especie.image()
	var property velocidad = especie.velocidad()

	method moverse() {
		
		position = position.left(1)
	}
	
	
	method disminuirVida(cant) {
		
		
		if (vida > 0) 
			
			vida -= cant
		
		if (vida<=0) {
			game.removeVisual(self)
			personaje.sumarPuntos()
		}
			
	}
	
	method agregarse() {
		 game.addVisual(self)
		 game.onCollideDo(self,{unElemento=>unElemento.chocasteConEnemigo(self)})
	     game.onTick(velocidad, "Movimiento Enemigo: " + self.toString(), {self.moverse()})
		
	}
	
	method chocasteConJugador() {}

	method chocasteConBorde() {
		gameOver.finalizarJuego() 
	}
	
	method chocasteConEnemigo(unEnemigo){
		
	}
}

class EspecieEnemigo {
	var property vida
	const property image
	var property velocidad 
	
}

object boss inherits Enemigo(position = game.at(11,6), especie = especieBoss ){
	

	method dispararPersonaje() {

		const proyEnemigo = new ProyectilEnemigo(position = self.position()) 
		game.addVisual(proyEnemigo)
		proyEnemigo.trayectoria()
	}
	
	override method disminuirVida(cant){
		
		if (vida > 0) 
			
			vida -= cant
		
		if (vida<=0) {
			game.removeVisual(self)
			personaje.sumarPuntos()
			game.removeTickEvent("BolaBoss")
		}
	}
}


const zombieBeta = new EspecieEnemigo (vida = 1, image = "zombie.png", velocidad = 1000)
const zombieAlfa = new EspecieEnemigo (vida = 2, image = "zombieAlfa.png", velocidad = 1500)
const zombieEsqueleto = new EspecieEnemigo (vida = 4, image = "zombieEsqueleto.png", velocidad = 1800)
const zombieEsqueletoBalde = new EspecieEnemigo (vida = 6, image = "zombieEsqueletoBalde.png", velocidad = 2500)
const zombieEsqueletoHalloween = new EspecieEnemigo (vida = 6, image = "zombieEsqueletoHalloween.png", velocidad = 2500)

const especieBoss = new EspecieEnemigo(vida = 10, image = "wollokGigante.png", velocidad = 4000)







