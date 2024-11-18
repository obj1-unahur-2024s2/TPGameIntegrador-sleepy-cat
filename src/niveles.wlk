import wollok.game.*

object pantallaDeInicio
{
    method siguiente()=nivel1
    method position()=game.origin()
    method image()="inicio.png"
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}
object nivel1
{
  method siguiente() = nivel2
  method position() = game.origin()
  method image() = "nivel2A.png"
  //method musicaDeFondo()=game.sound("battle.mp3")
  //var property seReprodujoElFondo=false
}
object nivel2
{
  method siguiente() = pantallaDeInicio
  method position() = game.origin()
  method image() = "nivel2B.png"
  //method musicaDeFondo()=game.sound("battle2.mp3")
  //var property seReprodujoElFondo=false
}

object pantalla
{
  var nivelActual=pantallaDeInicio
  method iniciar()
  {
    game.addVisual(nivelActual)
    //nivelActual.musicaDeFondo().shouldLoop(true)
    //nivelActual.musicaDeFondo().play()
    /*
    keyboard.p().onPressDo
    ({
      if(!nivelActual.seReprodujoElFondo()) 
      {
        nivelActual.musicaDeFondo().play()
        nivelActual.seReprodujoElFondo(true)
      }
      
		})
    */
    keyboard.enter().onPressDo
    ({
      game.removeVisual(nivelActual)
      //nivelActual.seReprodujoElFondo(false)
      //nivelActual.musicaDeFondo().stop()
      nivelActual=nivelActual.siguiente()
      //nivelActual.musicaDeFondo().shouldLoop(true)
      //nivelActual.musicaDeFondo().play()
      game.addVisual(nivelActual)
		})
  }
  
}