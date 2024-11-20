import niveles.*
import wollok.game.*
import personajes.*

//////////////////////////////////// Configuracion general del nivel ////////////////////////////////////

object finDelJuego {
  var property perdio = false
  method perdiste() {
    game.addVisual(gameOverScreen)
  }
  method reinicio() {
    if(self.perdio()){
      game.removeVisual(gameOverScreen)
      sleepyCat.energia(80)
      sleepyCat.position(game.origin())
			if(sleepyCat.llave()>0){
        game.addVisual(llave)
        sleepyCat.llave(0)
      }
      self.perdio(false)
    }
  }
}

object gameOverScreen {
  method position() = game.origin()
  method image() = 'gameOver.jpg'
}

//////////////////////////////////// Objetos del nivel 1 ////////////////////////////////////

object llave {
  method position() = game.at(8, 0)
  method image() = 'key.png'
  method dar() {
    if(sleepyCat.llave()){
      game.removeVisual(self)
      sleepyCat.obtenerLlave()      
    }
  }
  method colisionSleepy() {
    
  }

}
object juguete {
  const property position = game.at(2, 2) 
  method image() = 'ovillo.png'
  // Idea del juguete moviendose de forma random por el mapa
  // method movete() {
  //   const x = 0.randomUpTo(game.width()).truncate(0)
  //   const y = 0.randomUpTo(game.height()).truncate(0)
  //   position = game.at(x,y)
  // }
  method colisionSleepy() {
    game.removeVisual(self)
    sleepyCat.juguete(true)
  }
}

object comida{
  const property nutrientes = 30

  method position() = game.at(2, 6)
  method image() = 'pez.png'
  method colisionSleepy(){
    sleepyCat.comer(self)
  }
}

object maquinaExpendedora {
  var tieneComida = true
  method position() = game.at(0, 7)
  method darComida() {
    if(tieneComida){
      game.addVisual(comida)
      tieneComida = false
      game.onTick(10000, 'delay', {self.reponerComida()})
    }
  }
  method reponerComida(){
    game.removeTickEvent('delay')
    tieneComida = true
  }
  method colisionSleepy() {
    self.darComida()
  }
}

object chica1 {
  method position() = game.at(7, 3)
  method colisionSleepy() {
    game.say(self, 'Aww! que lindo gato!')
    game.say(chica2, 'Nos lo quedamos :P')
  }
}
object chica2 {
  method position() = game.at(8, 3)
    method colisionSleepy() {
    game.say(chica1, 'Aww! que lindo gato!')
    game.say(self, 'Nos lo quedamos :P')
  }
}
object displayDeStats {
  method position() = game.at(1, 10)
  method text() = 'Energia= ' + sleepyCat.energia() + ' Pos= ' + sleepyCat.position() + ' Llave= ' + sleepyCat.llave()

}
 /////////////////////////////////////////////// Muros /////////////////////////////////

const muro0 = new MuroDelimitante(position = game.at(2, 1))
const muro1 = new MuroDelimitante(position = game.at(3, 1))
const muro2 = new MuroDelimitante(position = game.at(4, 1))
const muro3 = new MuroDelimitante(position = game.at(5, 1))
const muro4 = new MuroDelimitante(position = game.at(6, 1))
const muro5 = new MuroDelimitante(position = game.at(4, 0))

const muro20 = new MuroDelimitante(position = game.at(2, 3))
const muro21 = new MuroDelimitante(position = game.at(3, 3))
const muro22 = new MuroDelimitante(position = game.at(4, 3))
const muro23 = new MuroDelimitante(position = game.at(5, 3))
const muro24 = new MuroDelimitante(position = game.at(6, 3))
const muro25 = new MuroDelimitante(position = game.at(4, 2))

const muro30 = new MuroDelimitante(position = game.at(2, 5))
const muro31 = new MuroDelimitante(position = game.at(3, 5))
const muro32 = new MuroDelimitante(position = game.at(4, 5))
const muro33 = new MuroDelimitante(position = game.at(5, 5))
const muro34 = new MuroDelimitante(position = game.at(6, 5))
const muro35 = new MuroDelimitante(position = game.at(4, 4))

const muro40 = new MuroDelimitante(position = game.at(9, 5))
const muro41 = new MuroDelimitante(position = game.at(10, 5))
const muro42 = new MuroDelimitante(position = game.at(11, 5))
const muro43 = new MuroDelimitante(position = game.at(12, 5))
const muro44 = new MuroDelimitante(position = game.at(13, 5))
const muro45 = new MuroDelimitante(position = game.at(11, 4))

const muro50 = new MuroDelimitante(position = game.at(9, 3))
const muro51 = new MuroDelimitante(position = game.at(10, 3))
const muro52 = new MuroDelimitante(position = game.at(11, 3))
const muro53 = new MuroDelimitante(position = game.at(12, 3))
const muro54 = new MuroDelimitante(position = game.at(13, 3))
const muro55 = new MuroDelimitante(position = game.at(11, 2))

const muro60 = new MuroDelimitante(position = game.at(9, 1))
const muro61 = new MuroDelimitante(position = game.at(10, 1))
const muro62 = new MuroDelimitante(position = game.at(11, 1))
const muro63 = new MuroDelimitante(position = game.at(12, 1))
const muro64 = new MuroDelimitante(position = game.at(13, 1))



class MuroChicas inherits MuroDelimitante{
  override method colisionSleepy() {
    sleepyCat.choqueConChicas()
  }
}

const muroChica1 = new MuroChicas(position = game.at(7, 2))
const muroChica2 = new MuroChicas(position = game.at(8, 2))

object cerradura inherits MuroDelimitante(position = game.at(7, 6)){
  override method colisionSleepy(){
    if(sleepyCat.llave())
      game.addVisual(puerta)
  }
}

object puerta inherits MuroDelimitante(position = game.at(7,7)){
  method image() = 'puertaAbierta.png'
  override method colisionSleepy() {
    if(sleepyCat.llave())
    game.removeTickEvent('patrullar')
    pantalla.siguienteNivel()
  } 
}