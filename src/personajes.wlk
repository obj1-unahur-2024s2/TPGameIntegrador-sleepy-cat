import wollok.game.*
import nivel1.*


object sleepyCat {
  // Para pruebas
  // method text() = 'E: ' + self.energia()
  // method text() = 'P:' + self.position() + '- L:' + self.llave()

  var property energia = 30
  method energia() = energia
  method image() = if(energia > 0) 'sleepyCatA.png' else 'sleepyCatDurmiendoA.png' 
  
  var position = game.origin()
  method position() = position
  method position(unaPosicion) {
    if(energia == 0){
      position = self.position()
      finDelJuego.perdio(true)
      finDelJuego.perdiste()
    }else{
      position = unaPosicion
      energia = 0.max(energia - 1)
    }
  }

}