import wollok.game.*
import nivel1.*
import nivel2.*
import personajes.*
import musica.*

object pantalla {
  var nivelActual = pantallaDeInicio
  method nivelActual() = nivelActual
  var property perdio = false

  method iniciar() {
    var personajeActivo = false
    //Teclas del juego
    game.schedule(3000, {musica.comenzar()})
    keyboard.p().onPressDo{musica.comenzar()}
		keyboard.r().onPressDo{nivelActual.reinicio()}
    keyboard.enter().onPressDo({if(self.condicionEnter()) self.siguienteNivel()})
    keyboard.e().onPressDo({if(self.condicionInteraccion(sleepyCat2.ultimoInteractuable())) sleepyCat2.ultimoInteractuable().interactuar()})
    //Teclas para testing
    keyboard.q().onPressDo{ //Para reiniciar la visual de sleepy 1
      if(personajeActivo){
        game.removeVisual(sleepyCat2)
        personajeActivo = false
      }else{
        game.addVisualCharacter(sleepyCat2)
        personajeActivo = true
      }
    }
    keyboard.n().onPressDo({self.siguienteNivel()}) // Para saltar niveles

    // Mecanicas de sleepy 1 y 2
    game.onCollideDo(sleepyCat2, {objeto => objeto.colisionSleepy()})

    keyboard.right().onPressDo({sleepyCat2.derecha()})
    keyboard.left().onPressDo({sleepyCat2.izquierda()})
    keyboard.up().onPressDo({sleepyCat2.arriba()})
    keyboard.down().onPressDo({sleepyCat2.abajo()})
    keyboard.space().onPressDo({if(self.condicionAtaque()) sleepyCat2.ataque()})
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

  // Validaciones 
  method condicionEnter() = nivelActual.descripcion() != 1 and nivelActual.descripcion() != 2
  method condicionAtaque() = nivelActual.descripcion() == 2
  method condicionInteraccion(unObjeto) =  sleepyCat2.position() == unObjeto.position()

  // Pasar a siguiente nivel
  method siguienteNivel(){
    musica.terminar()
    nivelActual.retirarVisuales()
  
    nivelActual = nivelActual.siguiente()
    musica.cambiarMusica(nivelActual.musica())

    musica.comenzar()
    nivelActual.agregarVisuales()
  }
  method perdiste() {
    game.addVisual(gameOverScreen)
    efectos.perdiste()
  }
}
//////////////////////////////////// Configuracion general de niveles ////////////////////////////////////

object gameOverScreen {
  method position() = game.origin()
  method image() = 'gameOver2.png'
}

object displayDeStats {
  var property position = game.at(0, 10)
  method image() = energiaAl100.mostrar() + '.png'
  // method text() = 'Energia= ' + sleepyCat2.energia() + ' Pos= ' + sleepyCat2.position() + ' Llave= ' + sleepyCat2.llave()
  method textColor() = paleta.rojo()
}
object paleta {
  const property rojo = "FF0000FF"
}
object energiaAl100 {
  method mostrar() = if(sleepyCat2.energiaP() > 75) '100' else energiaAl75.mostrar()
}
object energiaAl75 {
  method mostrar() = if(sleepyCat2.energiaP() > 50) '75' else energiaAl50.mostrar()
}
object energiaAl50 {
  method mostrar() = if(sleepyCat2.energiaP() > 25) '50' else energiaAl25.mostrar()
}
object energiaAl25 {
  method mostrar() = if(sleepyCat2.energiaP() > 10) '25' else '0'
}

////////////////////////////////////////////// Niveles ///////////////////////////////////
object pantallaDeInicio
{
    method descripcion() = 0
    method musica() = game.sound('menu.mp3')
    method siguiente() = instrucciones1
    method position() = game.origin()
    method image() = "inicio.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }
    
    method reinicio() {}

    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}

object instrucciones1
{
    method descripcion() = 0.5
    method musica() = game.sound('menu.mp3')
    method siguiente() = nivel1
    method position() = game.origin()
    method image() = "nivel1Lore.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }
    method reinicio() {}
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}
object nivel1 {
  method descripcion() = 1
  method musica() = game.sound('battle.mp3')
  method siguiente() = instrucciones2
  method position() = game.origin()
  method image() = "nivel1.png"
  method limiteX() = [0,15]
  method limiteY() = [0,7]

  method colisionSleepy(){}
  method reinicio() {
    if(pantalla.perdio()){
      game.removeVisual(gameOverScreen)
      sleepyCat2.energia(80)
      sleepyCat2.position(game.origin())
			if(sleepyCat2.llave()){
        game.addVisual(llave)
        sleepyCat2.llave(false)
      }
      if(sleepyCat2.juguete()){
        game.addVisual(juguete)
        sleepyCat2.juguete(false)
      }
      pantalla.perdio(false)
    } 
  } 
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
    game.addVisual(sleepyCat2)
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
    game.removeVisual(sleepyCat2)
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
    method musica() = game.sound('menu.mp3')
    method siguiente() = nivel2
    method position() = game.origin()
    method image() = "nivel2Lore.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
    }
    method reinicio() {}
  
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}

object nivel2
{
  method descripcion() = 2
  method musica() = game.sound('battle2.mp3')
  method siguiente() = pantallaFinal
  method position() = game.origin()
  method image() = "nivel2B.png"
  method limiteX() = [2,13]
  method limiteY() = [1,2]
  method reinicio() {
    if(pantalla.perdio()){
      sleepyCat2.energia(90)
      enemigo.vida(5)
      sleepyCat2.position(game.at(1, 7))
      pantalla.perdio(false)
      game.removeVisual(gameOverScreen)
    }
  }

  method agregarVisuales() {
    game.addVisual(self)
    game.addVisual(enemigo)
    game.addVisual(caja1)
    game.addVisual(caja2)
    game.addVisual(caja3)
    game.addVisual(caja4)
    game.addVisual(sleepyCat2)
    sleepyCat2.position(game.at(7,1))
    sleepyCat2.energia(90)
    game.addVisual(displayDeStats)
    displayDeStats.position(game.at(4,13))
    murosDelimitantes2.agregar()
  }
  method retirarVisuales(){
    game.removeVisual(self)
    game.removeVisual(enemigo)
    game.removeVisual(caja1)
    game.removeVisual(caja2)
    game.removeVisual(caja3)
    game.removeVisual(caja4)
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
    method musica() = game.sound('menu.mp3')
    method siguiente() = pantallaDeInicio
    method position() = game.origin()
    method image() = "ganaste.png"

    method retirarVisuales() {
      game.removeVisual(self)
    }
    method agregarVisuales(){
      game.addVisual(self)
      self.resetGeneral()
    }
    method reinicio() {}
    method resetGeneral() {
      sleepyCat2.llave(false)
      sleepyCat2.juguete(false)
      sleepyCat2.energia(90)
      sleepyCat2.position().origin()
      enemigo.position(game.at(2,12))
      malaOnda.position(game.at(2,2))
    }
    //method musicaDeFondo()=game.sound("menu.mp3")
    //var property seReprodujoElFondo=false
}
class MuroDelimitante{
  const property position
  method colisionSleepy() {
    sleepyCat2.choqueConMuro()
  }

  method recibirDisparo(bal) {
    sleepyCat2.balas().add(bal)
    game.removeVisual(bal)
    bal.quitarMovimiento()
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

