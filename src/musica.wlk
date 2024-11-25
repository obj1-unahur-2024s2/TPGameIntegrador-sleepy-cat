import niveles.*
import wollok.game.*

object musica {
	const volumenGeneral = 0.8
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