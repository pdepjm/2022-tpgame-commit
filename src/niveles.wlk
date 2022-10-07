import wollok.game.*
import direcciones.* 
import juego.*
import personajes.*
import elementosJuego.*

object inicio {

	method position() = game.at(0,0)
	
	method image() = "inicio.jpeg"

	method configuracionInicial(){
		game.addVisual(self)
		keyboard.e().onPressDo({primerNivel.configuracionInicial()})
	}
}

object primerNivel {
	const zombies = [new ZombieBeta(position = game.at(22, 12)), new ZombieBeta(position = game.at(22, 14)), new ZombieBeta(position = game.at(22, 16)), new ZombieBeta(position = game.at(22, 18))] 

	method configuracionInicial(){
		game.removeVisual("inicio.jpeg")
		juego.agregarPersonajes()
		juego.configurarTeclasNiveles()
		music1.play()
		zombies.forEach{zombie=> zombie.agregarse()}
		personaje.vida().forEach{corazon => corazon.agregarse()}
		imagenDelContador.agregarse()
		contadorDeBalas.agregarse()
	}
					
}


object segundoNivel {
	
}


object tercerNivel {
	
}