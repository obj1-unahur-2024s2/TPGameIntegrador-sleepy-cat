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

//BALAS
object bala1 {
  var property position = sleepyCat2.position()
  const property nombreTick = "Mov1"
  method image() = "sleepyCatAtaque32x32.png"
  method moverAdelante(){
    position = position.up(1)
  }
  method cambiarPosition(pos){
    position = pos
  }
  method activarMovimiento(){
    game.onTick(100, nombreTick, {self.moverAdelante()})
  }
  method recibirDisparo(unaBala){}
}
object bala2 {
  var property position = sleepyCat2.position()
  const property nombreTick = "Mov2"
  method image() = "sleepyCatAtaque32x32.png"
  method moverAdelante(){
    position = position.up(1)
  }
  method cambiarPosition(pos){
    position = pos
  }
  method activarMovimiento(){
    game.onTick(100, nombreTick, {self.moverAdelante()})
  }
}

object bala3 {
  var property position = sleepyCat2.position()
  const property nombreTick = "Mov3"
  method image() = "sleepyCatAtaque32x32.png"
  method moverAdelante(){
    position = position.up(1)
  }
  method cambiarPosition(pos){
    position = pos
  }
  method activarMovimiento(){
    game.onTick(100, nombreTick, {self.moverAdelante()})
  }
}

object bala4 {
  var property position = sleepyCat2.position()
  const property nombreTick = "Mov4"
  method image() = "sleepyCatAtaque32x32.png"
  method moverAdelante(){
    position = position.up(1)
  }
  method cambiarPosition(pos){
    position = pos
  }
  method activarMovimiento(){
    game.onTick(100, nombreTick, {self.moverAdelante()})
  }
}

object bala5 {
  var property position = sleepyCat2.position()
  const property nombreTick = "Mov5"
  method image() = "sleepyCatAtaque32x32.png"
  method moverAdelante(){
    position = position.up(1)
  }
  method cambiarPosition(pos){
    position = pos
  }
  method activarMovimiento(){
    game.onTick(100, nombreTick, {self.moverAdelante()})
  }
}

