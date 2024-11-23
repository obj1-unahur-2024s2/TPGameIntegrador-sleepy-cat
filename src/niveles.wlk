import wollok.game.*
import nivel1.*
import nivel2.*
import personajes.*

object pantalla {
  var nivelActual = pantallaDeInicio
  var property perdio = false

  method iniciar() {
    var personajeActivo = false
    //Teclas del juego
		keyboard.r().onPressDo{reinicio.reinicioN1(nivelActual)}
    keyboard.enter().onPressDo({if(self.condicionEnter()) self.siguienteNivel()})
    //Teclas para testing
    keyboard.q().onPressDo{ //Para reiniciar la visual de sleepy 1
      if(personajeActivo){
        game.removeVisual(sleepyCat)
        personajeActivo = false
      }else{
        game.addVisualCharacter(sleepyCat)
        personajeActivo = true
      }
    }
    keyboard.n().onPressDo({self.siguienteNivel()}) // Para saltar niveles

    // Mecanicas de sleepy 1 y 2
    game.onCollideDo(sleepyCat, {objeto => objeto.colisionSleepy()})
    keyboard.right().onPressDo({sleepyCat2.derecha()})
    keyboard.left().onPressDo({sleepyCat2.izquierda()})
    keyboard.space().onPressDo({sleepyCat2.ataque()})
    // Mecanicas de las balas
    game.onCollideDo(bala1, {p => p.recibirDisparo(bala1)})
    game.onCollideDo(bala2, {p => p.recibirDisparo(bala2)})
    game.onCollideDo(bala3, {p => p.recibirDisparo(bala3)})
    game.onCollideDo(bala4, {p => p.recibirDisparo(bala4)})
    game.onCollideDo(bala5, {p => p.recibirDisparo(bala5)})
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
  }
  method condicionEnter() = 
    nivelActual.descripcion() == 0 or
    nivelActual.descripcion() == 0.5 or
    nivelActual.descripcion() == 1.5 or
    nivelActual.descripcion() == 3
  
  method siguienteNivel(){
    nivelActual.retirarVisuales()
    //nivelActual.seReprodujoElFondo(false)
    //nivelActual.musicaDeFondo().stop()
    nivelActual=nivelActual.siguiente()
    //nivelActual.musicaDeFondo().shouldLoop(true)
    //nivelActual.musicaDeFondo().play()
    nivelActual.agregarVisuales()
  }
  method perdiste() {
    game.addVisual(gameOverScreen)
  }
}
//////////////////////////////////// Configuracion general de niveles ////////////////////////////////////


object reinicio {
  method reinicioN1(nivel) {
    if(pantalla.perdio() and nivel.descripcion() == 1){
      game.removeVisual(gameOverScreen)
      sleepyCat.energia(80)
      sleepyCat.position(game.origin())
			if(sleepyCat.llave()){
        game.addVisual(llave)
        sleepyCat.llave(false)
      }
      if(sleepyCat.juguete()){
        game.addVisual(juguete)
        sleepyCat.juguete(false)
      }
      pantalla.perdio(false)
    }else{
      self.reinicioN2(nivel)
    }
  }

  method reinicioN2(nivel) {
    if(pantalla.perdio() and nivel.descripcion() == 2){
      game.removeVisual(gameOverScreen)
      sleepyCat.energia(80)
      sleepyCat.position(game.at(1, 7))
      pantalla.perdio(false)
    }
  }
}

object gameOverScreen {
  method position() = game.origin()
  method image() = 'gameOver2.png'
}

object displayDeStats {
  method position() = game.at(1, 12)
  method text() = 'Energia= ' + sleepyCat.energia() + ' Pos= ' + sleepyCat.position() + ' Llave= ' + sleepyCat.llave()
  method textColor() = paleta.rojo()
}
object paleta {
  const property rojo = "FF0000FF"
}

////////////////////////////////////////////// Niveles ///////////////////////////////////
object pantallaDeInicio
{
    method descripcion() = 0
    method siguiente()=instrucciones1
    method position()=game.origin()
    method image()="inicio.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }

    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}

object instrucciones1
{
    method descripcion() = 0.5
    method siguiente() = nivel1
    method position() = game.origin()
    method image() = "nivel1Lore.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }

    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}
object nivel1
{
  method descripcion() = 1
  method siguiente() = instrucciones2
  method position() = game.origin()
  method image() = "nivel1.png"
  method colisionSleepy(){}
  method agregarVisuales() {
    game.addVisual(self)
    murosDelimitantes.agregar()
    game.addVisual(gatoNegro)
    game.addVisual(malaOnda)
    game.addVisual(maquinaExpendedora)
    game.addVisual(chica1)
    game.addVisual(chica2)
    game.addVisual(llave)
    game.addVisual(cerradura)
    game.addVisual(displayDeStats)
    game.addVisualCharacter(sleepyCat)
  }
  method retirarVisuales() {
    game.removeVisual(self)
    game.removeVisual(gatoNegro)
    game.removeVisual(malaOnda)
    game.removeVisual(maquinaExpendedora)
    game.removeVisual(chica1)
    game.removeVisual(chica2)
    game.removeVisual(llave)
    game.removeVisual(cerradura)
    game.removeVisual(puerta)
    game.removeVisual(displayDeStats)
    game.removeVisual(sleepyCat)
    murosDelimitantes.quitar()
  }
  //method musicaDeFondo()=game.sound("battle.mp3")
  //var property seReprodujoElFondo=false
}

object murosDelimitantes {
  method agregar() {
    game.addVisual(muro0)
    game.addVisual(muro1)
    game.addVisual(muro2)
    game.addVisual(muro3)
    game.addVisual(muro4)
    game.addVisual(muro5)

    game.addVisual(muro20)
    game.addVisual(muro21)
    game.addVisual(muro22)
    game.addVisual(muro23)
    game.addVisual(muro24)
    game.addVisual(muro25)

    game.addVisual(muro30)
    game.addVisual(muro31)
    game.addVisual(muro32)
    game.addVisual(muro33)
    game.addVisual(muro34)
    game.addVisual(muro35)

    game.addVisual(muro40)
    game.addVisual(muro41)
    game.addVisual(muro42)
    game.addVisual(muro43)
    game.addVisual(muro44)  
    game.addVisual(muro45)  
  
    game.addVisual(muro50)
    game.addVisual(muro51)
    game.addVisual(muro52)
    game.addVisual(muro53)
    game.addVisual(muro54)  
    game.addVisual(muro55)  
  
    game.addVisual(muro60)
    game.addVisual(muro61)
    game.addVisual(muro62)
    game.addVisual(muro63)
    game.addVisual(muro64)  

    game.addVisual(muroChica1)
    game.addVisual(muroChica2)
  }
  method quitar() {
    game.removeVisual(muro0)
    game.removeVisual(muro1)
    game.removeVisual(muro2)
    game.removeVisual(muro3)
    game.removeVisual(muro4)
    game.removeVisual(muro5)

    game.removeVisual(muro20)
    game.removeVisual(muro21)
    game.removeVisual(muro22)
    game.removeVisual(muro23)
    game.removeVisual(muro24)
    game.removeVisual(muro25)

    game.removeVisual(muro30)
    game.removeVisual(muro31)
    game.removeVisual(muro32)
    game.removeVisual(muro33)
    game.removeVisual(muro34)
    game.removeVisual(muro35)

    game.removeVisual(muro40)
    game.removeVisual(muro41)
    game.removeVisual(muro42)
    game.removeVisual(muro43)
    game.removeVisual(muro44)  
    game.removeVisual(muro45)  
  
    game.removeVisual(muro50)
    game.removeVisual(muro51)
    game.removeVisual(muro52)
    game.removeVisual(muro53)
    game.removeVisual(muro54)  
    game.removeVisual(muro55)  
  
    game.removeVisual(muro60)
    game.removeVisual(muro61)
    game.removeVisual(muro62)
    game.removeVisual(muro63)
    game.removeVisual(muro64)  

    game.removeVisual(muroChica1)
    game.removeVisual(muroChica2)   
  }
}

object instrucciones2
{
    method descripcion() = 1.5
    method siguiente() = nivel2
    method position() = game.origin()
    method image() = "nivel2Lore.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }
  
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}

object nivel2
{
  method descripcion() = 2
  method siguiente() = pantallaFinal
  method position() = game.origin()
  method image() = "nivel2B.png"

  method agregarVisuales() {
    game.addVisual(self)
    game.addVisual(enemigo)
    game.addVisual(caja1)
    game.addVisual(sleepyCat2)
    game.addVisual(displayDeStats)
    murosDelimitantes2.agregar()
  }
  method retirarVisuales(){
    game.removeVisual(self)
    game.removeVisual(enemigo)
    game.removeVisual(caja1)
    game.removeVisual(sleepyCat2)
    game.removeVisual(displayDeStats)
    murosDelimitantes2.quitar()
  }
  method colisionSleepy() {
    
  }

  //method musicaDeFondo()=game.sound("battle2.mp3")
  //var property seReprodujoElFondo=false
}
object pantallaFinal
{
    method descripcion() = 3
    method siguiente() = pantallaDeInicio
    method position() = game.origin()
    method image() = "ganaste.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }
  
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}
class MuroDelimitante{
  const property position
  method colisionSleepy() {
    sleepyCat.choqueConMuro()
  }

  method recibirDisparo(bal) {
    sleepyCat2.balas().add(bal)
  }
  // Para pruebas:
  // method image() = 'test-edit.png' 
}


object murosDelimitantes2 {
  method agregar() {
    game.addVisual(muro110)
    game.addVisual(muro111)
    game.addVisual(muro112)
    game.addVisual(muro113)
    game.addVisual(muro114)
    game.addVisual(muro115)
    game.addVisual(muro116)
    game.addVisual(muro117)
    game.addVisual(muro118)
    game.addVisual(muro119)
    game.addVisual(muro120)
    game.addVisual(muro121)
    game.addVisual(muro122)
    game.addVisual(muro123)
    game.addVisual(muro124)
    game.addVisual(muro125)
  }
  method quitar() {
    game.removeVisual(muro110)
    game.removeVisual(muro111)
    game.removeVisual(muro112)
    game.removeVisual(muro113)
    game.removeVisual(muro114)
    game.removeVisual(muro115)
    game.removeVisual(muro116)
    game.removeVisual(muro117)
    game.removeVisual(muro118)
    game.removeVisual(muro119)
    game.removeVisual(muro120)
    game.removeVisual(muro121)
    game.removeVisual(muro122)
    game.removeVisual(muro123)
    game.removeVisual(muro124)
    game.removeVisual(muro125)
  }
}

