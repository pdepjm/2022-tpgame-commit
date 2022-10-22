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
	     game.onTick(especie.velocidad(), "Movimiento Enemigo", {self.moverse()})
		
	}
	
	method chocasteConJugador() {}

	method chocasteConBorde() {
		gameOver.finalizarJuego() 
	}
	
}

class EspecieZombie {
	var property vida
	const property image
	var property velocidad 
		
}

class EspecieBoss {
	var property vida
	const property image
	var property velocidad

	method dispararPersonaje() {

		const proyEnemigo = new ProyectilEnemigo() 
		
		game.addVisual(proyEnemigo)
		
		proyEnemigo.trayectoria()
	}
}


const zombieBeta = new EspecieZombie (vida = 1, image = "zombie.png", velocidad = 1000)
const zombieAlfa = new EspecieZombie (vida = 2, image = "zombieAlfa.png", velocidad = 1500)

const boss = new EspecieBoss(vida = 7, image = "wollokGigante.png", velocidad = 4000)







