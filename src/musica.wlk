import niveles.*
import wollok.game.*

object musica {
	const volumenGeneral = 0.3
	var musicaActual = pantalla.nivelActual().musica()
	method cambiarMusica(musicaDeUnNivel) {
		musicaActual = musicaDeUnNivel
	}
	method comenzar() {
		musicaActual.shouldLoop(true)
		musicaActual.play()
		musicaActual.volume(volumenGeneral)
	}
	method terminar() {
		musicaActual.stop()
	}
}
object efectos {
	method perdiste() {
		game.sound('perdiste.mp3').play()
	}
	method cansado() {
		game.sound('cansado.mp3').play()
	}
}