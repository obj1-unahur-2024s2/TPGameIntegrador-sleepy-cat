import wollok.game.*
import nivel1.*

////////////////////////////////////////// Personaje principal //////////////////////////////////////////
object sleepyCat {
  var property energia = 40
  method image() = if(energia > 0) 'sleepyCatA.png' else 'sleepyCatDurmiendoA.png' 
  
  var position = game.at(0, 0)
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

	// Otra forma de resolver colisiones con muros tal vez? 
  /*
  var property position = game.origin() 
  const posColision = [[4,4], [0,1]]
  method esUnaPosicionDeColision(unaPosicion) = posColision.contains({posicion => posicion == unaPosicion})
  */

  // Comportamiento con la llave
  var property llave = 0
  method obtenerLlave() {
    llave = llave + 1
    game.say(self, 'Tengo la llave !')
  }
  // Comportamiento de colision con un muro
  method choqueConMuro() {
    position = game.origin()
    game.say(self, 'Oh no :( )')
  }
	// Comportamiento de colision con las chicas
  method choqueConChicas() {
    energia = 0
    game.say(self, 'Los mimos me dan sueño')
  }
}

////////////////////////////////////////// Personajes secundarios //////////////////////////////////////////

object gatoNegro {
  method position() = game.at(8,0) 
  method meChocaron() {
    
  }
}