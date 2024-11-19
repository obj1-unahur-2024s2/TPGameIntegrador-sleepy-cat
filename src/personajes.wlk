import wollok.game.*
import nivel1.*

////////////////////////////////////////// Personaje principal //////////////////////////////////////////
object sleepyCat {
  var property energia = 90
  method image() = if(energia > 0) 'sleepyCat' + self.estado() + '.png' else 'sleepyCatDurmiendoA.png' 
  method estado() = if(not juguete) 'A' else 'Ovillo'

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

  //Comida
  method comer(comida) {
    energia = energia + comida.nutrientes()
    game.removeVisual(comida)
  }

	// Otra forma de resolver colisiones con muros tal vez? 
  /*
  var property position = game.origin() 
  const posColision = [[4,4], [0,1]]
  method esUnaPosicionDeColision(unaPosicion) = posColision.contains({posicion => posicion == unaPosicion})
  */

  // Comportamiento con la llave
  var property llave = false
  method obtenerLlave() {
    llave = true
    game.say(self, 'Tengo la llave !')
  }
  // Comportamiento con la llave
  var property juguete = false
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
  method colisionSleepy() {
    if(sleepyCat.juguete()){
      game.say(self, "Gracias !! te doy mi llave")
      sleepyCat.juguete(false)
      llave.dar()
      sleepyCat.obtenerLlave()
    }else{
      game.say(self, "Si me traes un juguete te doy mi llave")
      game.addVisual(juguete)
      malaOnda.cuidarJuguete()
    }
  }
}

object malaOnda {
  var orientacion = arriba
  var property position = game.at(2, 2) 
  method image() = 'test.png'

  method colisionSleepy() {
    sleepyCat.energia(0)
  }
  method seEnjoja(){
    game.say(self, 'No te subas ahí ! >:(')
  }
  method cuidarJuguete() {
    position = game.at(1, 2)
    game.onTick(500, 'patrullar', {self.patrullar()})
  }
  method patrullar() {
    self.avanzar()
    if(self.borde())
      self.girar()
  }
  method avanzar() {
    position = orientacion.adelante(position)
  }
  method girar() {
    orientacion = orientacion.opuesto()
  }
  method borde() = position.y() == 6 or position.y() == 0
}

object arriba {
  method adelante(posicion) = posicion.up(1)
  method opuesto() = abajo
}
object abajo {
  method adelante(posicion) = posicion.down(1)
  method opuesto() = arriba
}




////////////////////////////////////////// Personajes enemigo //////////////////////////////////////////

//game.addVisual(enemigo) en el nivel
//game.onCollideDo(disparo, {objeto => objeto.recibirDisparo()})

object enemigo {
  var position = game.at(1,1)
  var property vida = 5
  var orientacion = derecha

  method position() = position

  method image() = if(vida <= 0) 'perroAcostado.png' else 'perroA' + orientacion.descripcion() + '.png' 


  method initialize() {
    game.onTick(1000, 'enemigo', {if (vida > 0) self.movimientoRandom()} )
  }
  
  /*method movimientoNormal() {
    self.avanzar()
    if(self.llegoAlBorde()){
      orientacion = orientacion.opuesto()
    }
    
  }*/

  
  method movimientoRandom() {
    self.avanzar()
    if(self.llegoAlBorde() or talvez.seaCierto(20)){
      orientacion = orientacion.opuesto()
    }
    
  }
  

  method avanzar() {
    position = orientacion.adelante(position)
  }

  method llegoAlBorde() = orientacion.enElBorde(position)

  method recibirDisparo() {
    vida = vida - 1
    if (vida == 0){
      self.morir()
    }
    else{
      game.say(self, ">:(")
    }
  }

  method morir() {
    game.say(self, "Noooooo")
    
  }

}

object talvez {
  method seaCierto(porcentaje) = 0.randomUpTo(1)*100 < porcentaje
}

object derecha {
  method descripcion() = "Derecha"
  method siguiente() = izquierda
  method opuesto() = izquierda
  method adelante(position) = position.right(1)
  method enElBorde(position) = position.x() >= game.width()-1
}

object izquierda {
  method descripcion() = "Izquierda"
  method siguiente() = derecha
  method opuesto() = derecha
  method adelante(position) = position.left(1)
  method enElBorde(position) = position.x() <= 0

}


//// Cajas nivel 2 ////

class Caja{
  const property position
  var disparosRecibidos = 0
  var image = 'caja2.png'

  method recibirDisparo(){
    disparosRecibidos += 1
    self.cambiarImagen()
  }
  method image() = image
  method cambiarImagen(){
    if( disparosRecibidos == 1 ){ image = 'cajaRota2.png' }
    else { game.removeVisual(self)
          // sleepyCat.darEnergia()
     } 
  }
}