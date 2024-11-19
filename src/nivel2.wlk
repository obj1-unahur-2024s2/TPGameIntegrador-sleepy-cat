import niveles.*
import wollok.game.*
import personajes.*

object visuales{
  method agregarvisuales(){
  game.addVisual(sleepyCat2)
  game.addVisual(enemigo)
  game.addVisual(caja1)
  keyboard.right().onPressDo({sleepyCat2.derecha()})
  keyboard.left().onPressDo({sleepyCat2.izquierda()})
  keyboard.space().onPressDo({sleepyCat2.ataque()})
  game.onCollideDo(bala1, {p => p.recibirDisparo(bala1)})
  game.onCollideDo(bala2, {p => p.recibirDisparo(bala2)})
  game.onCollideDo(bala3, {p => p.recibirDisparo(bala3)})
  game.onCollideDo(bala4, {p => p.recibirDisparo(bala4)})
  game.onCollideDo(bala5, {p => p.recibirDisparo(bala5)})
}
}



