import niveles.*
import wollok.game.*
import personajes.*

class Caja{
  const property position
  var disparosRecibidos = 0
  var image = 'caja2.png'

  method recibirDisparo(bal){
    disparosRecibidos += 1
    self.cambiarImagen()
    sleepyCat2.balas().add(bal)
  }
  method image() = image
  method cambiarImagen(){
    if( disparosRecibidos == 1 ){ 
      image = 'cajaRota2.png' 
    }else { 
      game.removeVisual(self)
      // sleepyCat.darEnergia()
     } 
  }
}

const caja1 = new Caja(position = game.at(6, 7))



