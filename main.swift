/* 
Laboratorio 10 - Lenguajes de Programación
Swift
José Mario Carvajal Campos
2017146813
Profesora: Samanta Ramijan Carmiol
*/


//Esta clase representa a los instrumentos en general
class Instrumento {
  let marca: String
  
  //Constructor de la clase 
  init(marca: String) {
    self.marca = marca
  }

  //Salida: String con mensaje de error
  func melodia() -> String {
  fatalError("Corre este método para \(marca)")
}
//Entrada: variable tipo Musica
//Salida: Notas musicales
func tocar(_ musica: Musica) -> String {
  return musica.preparado()
}
//Entrada: variable tipo Musica
//Salida: String en terminal de las melodias 
func presentar(_ musica: Musica) {
  print(melodia())
  print(tocar(musica))
}
}

//Clase donde las notas musicales se almacenan por cada instancia
class Musica {
  let notas: [String]
  //Constructor de la clase,inicializa notas
  init(notas: [String]) {
    self.notas = notas
  }
  //Retorna las notas de la clase
  func preparado() -> String {
    return notas.joined(separator: " ")
  }
}

//Piano hereda de instrumento
class Piano: Instrumento {
  let tienePedales: Bool

  static let teclasBlancas = 52
  static let teclasNegras = 36
  
  init(marca: String, tienePedales: Bool = false) {
    self.tienePedales = tienePedales
    super.init(marca: marca)
  }
  
  Aqui modifica las dos funciones del padre
  override func melodia() -> String {
    return "Melodia de piano estandar para \(marca)."
  }
  
  override func tocar(_ musica: Musica) -> String {
    return tocar(musica, usaPedales: tienePedales)
  }

  func tocar(_ musica: Musica, usaPedales: Bool) -> String {
  let notasPreparadas = super.tocar(musica)
  if tienePedales && usaPedales {
    return "Tocar notas de piano \(notasPreparadas) con pedales."
  }
  else {
    return "Tocar notas de piano \(notasPreparadas) sin pedales."
  }
}

}

let piano = Piano(marca: "Yamaha", tienePedales: true)
piano.melodia()
let musica = Musica(notas: ["C", "G", "F"])
piano.tocar(musica, usaPedales: false)
piano.tocar(musica)
Piano.teclasBlancas
Piano.teclasNegras
//Guitarra hereda de instrumento
class Guitarra: Instrumento {
  let calibreDeCuerda: String
  
    
  init(marca: String, calibreDeCuerda: String = "medio") {
    self.calibreDeCuerda = calibreDeCuerda
    super.init(marca: marca)
  }
}
//Guitarra acustica hereda de guitarra
class GuitarraAcustica: Guitarra {
  static let numeroDeCuerdas = 6
  static let cuentatraste = 20
  
  override func melodia() -> String {
    return "Melodia \(marca) acustica con E A D G B E"
  }
  
  override func tocar(_ musica: Musica) -> String {
    let notasPreparadas = super.tocar(musica)
    return "Tocar melodias folcloricas en los trastes \(notasPreparadas)."
  }
}

let guitarraAcustica = GuitarraAcustica(marca: "Roland", numeroDeCuerdas: "ligero")
guitarraAcustica.melodia()
guitarraAcustica.tocar(musica)

//Nueva clase que defuine un amplificador
class Amplificador {
  //Variable privadas que solo pueden ser vistas en esta //clase
  private var _volumen: Int
  private(set) var encendido: Bool

  init() {
    encendido = false
    _volumen = 0
  }

  func conectado() {
    encendido = true
  }

  func desconectado() {
    encendido = false
  }

  var volumen: Int {
    get {
      return encendido? _volumen : 0
    }
    set {
      _volumen = min(max(newValue, 0), 10)
    }
  }
}
//Guitarra electrica hereda de guitarra
class GuitarraElectrica: Guitarra {
  let amplificador: Amplificador
  
  init(marca: String, numeroDeCuerdas: String = "ligero", amplificador: Amplificador) {
    self.amplificador = amplificador
    super.init(marca:marca, numeroDeCuerdas: numeroDeCuerdas)
  }
  
  override func melodia() -> String {
    amplificador.conectado()
    amplificador.volumen = 5
    return "Melodia \(marca) electrica con E A D G B E"
  }
  
  override func tocar(_ musica: Musica) -> String {
    let notasPreparadas = super.tocar(musica)
    return "Tocar solo \(notasPreparadas) con volumen \(amplificador.volumen)."
  }
}
//Bajo hereda de guitarra
class Bajo: Guitarra {
  let amplificador: Amplificador

  init(marca: String,numeroDeCuerdas: String = "Pesada", amplificador: Amplificador) {
    self.amplificador = amplificador
    super.init(marca: marca, numeroDeCuerdas: numeroDeCuerdas)
  }

  override func melodia() -> String {
    amplificador.conectado()
    return "Melodia \(marca) bajo con E A D G"
  }

  override func tocar(_ musica: Musica) -> String {
    let notasPreparadas = super.tocar(musica)
    return "Tocar bajo \(notasPreparadas) con volumen \(amplificador.volumen)."
  }
}

let amplificador = Amplificador()
let guitarraElectrica = GuitarraElectrica(marca: "Gibson", numeroDeCuerdas: "media", amplificador: amplificador)
guitarraElectrica.melodia()

let bajo= Bajo(marca: "Fender", numeroDeCuerdas: "Pesada", amplificador: amplificador)
bajo.melodia()

bajo.amplificador.volumen
guitarraElectrica.amplificador.volumen

bajo.amplificador.desconectado()
bajo.amplificador.volumen
guitarraElectrica.amplificador.volumen

bajo.amplificador.conectado()
bajo.amplificador.volumen
guitarraElectrica.amplificador.volumen

class Banda {
  let instrumentos: [Instrumento]
  
  init(instrumentos: [Instrumento]) {
    self.instrumentos = instrumentos
  }
  
  func presentar(_ musica: Musica) {
    for instrumento in instrumentos {
      instrumento.presentar(musica)
    }
  }
}

let instrumentos = [piano, guitarraAcustica, guitarraElectrica, bajo]
let banda = Banda(instrumentos: instrumentos)
banda.presentar(musica)