import wollok.game.*
import personajes.*


object nivel1 {
  method iniciar() {
    config.nivel1()
  }
}

object config {
  method nivel1() {
    game.title("Sleepy Game")
	  game.height(14)
	  game.width(16)
	  game.cellSize(64)
	  game.boardGround("nivel1.png")
    game.addVisualCharacter(sleepyCat)
		keyboard.space().onPressDo{finDelJuego.reinicio()}
  }
  
}

object finDelJuego {
  var property perdio = false
  method perdiste() {
    game.addVisual(gameOverScreen)
  }
  method reinicio() {
    if(self.perdio()){
      game.removeVisual(gameOverScreen)
      sleepyCat.energia(30)
      sleepyCat.position(game.origin())
      self.perdio(false)
    }
  }
}

object gameOverScreen {
  method position() = game.origin()
  method image() = 'gameOver.jpg'
}