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
  method recibirDisparo(unaBala){}
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
  method recibirDisparo(unaBala){}
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
  method recibirDisparo(unaBala){}
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
  method recibirDisparo(unaBala){}
}

const muro110 = new MuroDelimitante(position = game.at(0, 14))
const muro111 = new MuroDelimitante(position = game.at(1, 14))
const muro112 = new MuroDelimitante(position = game.at(2, 14))
const muro113 = new MuroDelimitante(position = game.at(3, 14))
const muro114 = new MuroDelimitante(position = game.at(4, 14))
const muro115 = new MuroDelimitante(position = game.at(5, 14))
const muro116 = new MuroDelimitante(position = game.at(6, 14))
const muro117 = new MuroDelimitante(position = game.at(7, 14))
const muro118 = new MuroDelimitante(position = game.at(8, 14))
const muro119 = new MuroDelimitante(position = game.at(9, 14))
const muro120= new MuroDelimitante(position = game.at(10, 14))
const muro121= new MuroDelimitante(position = game.at(11, 14))
const muro122= new MuroDelimitante(position = game.at(12, 14))
const muro123= new MuroDelimitante(position = game.at(13, 14))
const muro124 = new MuroDelimitante(position = game.at(14, 14))
const muro125 = new MuroDelimitante(position = game.at(15, 14))
