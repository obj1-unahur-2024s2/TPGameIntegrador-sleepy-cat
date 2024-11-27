import niveles.*
import wollok.game.*
import nivel1.*
import nivel2.*


////////////////////////////////////////// Personaje principal //////////////////////////////////////////
/*
object sleepyCat {
  var property energia = 90
  method image() = if(energia > 0) 'sleepyCat' + self.estado() + '.png' else 'sleepyCatDurmiendoA.png' 
  method estado() = if(not juguete) 'A' else 'Ovillo'

  var position = game.at(0, 0)
  method position() = position
  method position(unaPosicion) {
    if(energia <= 0){
      position = self.position()
      pantalla.perdio(true)
      pantalla.perdiste()
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
*/

object sleepyCat2 {
  const energiaInicial = 90
  var property ultimoInteractuable = maquinaExpendedora
    
  var property energia = energiaInicial
  method energiaP() = (energia * 100)/energiaInicial
  var image = 'sleepyCatA.png' 
  method image() = image

  //Movimiento
  var position = game.origin()
  method position() = position 
  method position(unaPosicion) {
    if(self.xEsValida(unaPosicion.x()) and self.yEsValida(unaPosicion.y())){
      self.avanzar(unaPosicion)
    }
  }
  method avanzar(unaPosicion) {
    if(energia > 0){
      position = unaPosicion
      energia = 0.max(energia - 1)
    }else{
      image = 'sleepyCatDurmiendoA.png'
      position = self.position()
      pantalla.perdio(true)
      pantalla.perdiste()
    }
  }

  method xEsValida(unaPosicion){
    const maximo = pantalla.nivelActual().limiteX().last()
    const minimo = pantalla.nivelActual().limiteX().first()
    return unaPosicion.between(minimo, maximo)
  }
  method yEsValida(unaPosicion){
    const maximo = pantalla.nivelActual().limiteY().last()
    const minimo = pantalla.nivelActual().limiteY().first()
    return unaPosicion.between(minimo, maximo)
  }

  var posicionAntX = 0
  var posicionAntY = 0

  method posicionAntXL() {
    posicionAntX = position.x() + 1
  }
  method posicionAntXR() {
    posicionAntX = position.x() - 1
  }
  method posicionAntYU() {
    posicionAntY = position.y() - 1
  }
  method posicionAntYD() {
    posicionAntY = position.y() + 1
  }

  method izquierda(){
    self.position(position.left(1))
    self.posicionAntXL()
    image = 'sleepyCatA.png'
  }
  method derecha(){
    self.position(position.right(1))
    self.posicionAntXR()
    image = 'sleepyCatADerecha.png'    
  }

  method arriba(){
   self.position(position.up(1))
   self.posicionAntYU()
   image = 'sleepyCatAUp.png'
  }
  method abajo(){
   self.position(position.down(1))
   self.posicionAntYD()
   image = 'sleepyCatADown.png'
  }

  method darEnergia(){
    energia = energia + 5
  }
  //Comida
  method comer(comida) {
    energia = energia + comida.nutrientes()
    game.removeVisual(comida)
  }

  //Comportamiento nivel 1
  var property llave = false
  method obtenerLlave() {
    llave = true
    //self.cambiarInteractuable(llave)
    //dialogoLlave.mostrarDialogo()
    
    //game.say(self, 'Tengo la llave !')
  }

  var property juguete = false
  
  //Balas y ataque nivel 2
  const property balas = [bala1, bala2, bala3, bala4, bala5]
  method ataque(){
    if(energia > 0){
    energia = energia - 1
    const balaUsada = balas.first()
    balaUsada.cambiarPosition(self.position().up(1))
    balas.remove(balaUsada)
    game.addVisual(balaUsada)
    balaUsada.activarMovimiento()}
    else {
      position = self.position()
      pantalla.perdio(true)
      pantalla.perdiste()
    }
  }
  //Colisiones
  method choqueConMuro() {
    position = game.at(posicionAntX, posicionAntY)
  }
  method choqueConChicas() {
    energia = 0
    image = 'sleepyCatDurmiendoA.png'
    game.schedule(500, {dialogoConChicas.mostrarDialogo()})
    game.schedule(2500, {dialogoConChicas.sacarDialogo()})
  }
  method colision(tap){}
  method recibirDisparo(bal){}

  method cambiarInteractuable(interactuable) {
    ultimoInteractuable = interactuable
  }
  
}

object dialogoConChicas {
  const property position = game.origin()
  method image()  = 'sleepyCatDialogo2.png'
  
  method mostrarDialogo() {
    game.addVisual(self)
  }

  method sacarDialogo() {
    game.removeVisual(self)
  }
}

object dialogoLlave {
  const property position = game.origin()
  method image() = 'sleepyCatDialogo1.png'

  method mostrarDialogo() {
    game.addVisual(self)
  }

  method sacarDialogo() {
    game.removeVisual(self)
  }

}

////////////////////////////////////////// Personajes secundarios //////////////////////////////////////////

object gatoNegro {
  method position() = game.at(8,0) 
  method colisionSleepy() {
    sleepyCat2.cambiarInteractuable(self)
    if(sleepyCat2.juguete()){
      gatoDialogos.mostrarDialogo2()
      sleepyCat2.juguete(false)
      llave.dar()
      sleepyCat2.obtenerLlave()
      game.removeVisual(llave)
    }
  }

  method interactuar(){
    if(game.hasVisual(gatoDialogos)){
      gatoDialogos.sacarDialogo()
    }
    else {
      game.addVisual(juguete)
      gatoDialogos.mostrarDialogo()
      malaOnda.cuidarJuguete()
      }
  }
}

object malaOnda {
  var orientacion = arriba
  var property position = game.at(2, 2) 
  method image() = 'malaOnda1.png'

  method colisionSleepy() {
    sleepyCat2.energia(0)
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
  var property position = game.at(2,12)
  var property vida = 5
  var orientacion = derecha

  method position() = position

  method image() = if(vida <= 0) 'perroAcostado.png' else 'perroA' + orientacion.descripcion() + '.png' 


  method initialize() {
    game.onTick(1000, 'enemigo', {if (vida > 0) self.movimientoNormal()} )
  }
  
 method movimientoNormal() {
    self.avanzar()
    if(self.llegoAlBorde()){
      orientacion = orientacion.opuesto()
    }
    
  }

  
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

  method recibirDisparo(bal) {
    game.removeVisual(bal)
    vida = vida - 1
    sleepyCat2.balas().add(bal)
    if (vida == 0){
      self.morir()
    }
    else{
      game.say(self, ">:(")
    }
  }

  method morir() {
    game.say(self, "Noooooo")
    game.removeTickEvent('enemigo')
    pantalla.siguienteNivel()
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
  method enElBorde(position) = position.x() >= 13
}

object izquierda {
  method descripcion() = "Izquierda"
  method siguiente() = derecha
  method opuesto() = derecha
  method adelante(position) = position.left(1)
  method enElBorde(position) = position.x() <= 2

}


