
final public class Musica {
  
  public let notas: [String]

  public init(notas: [String]) {
    self.notas = notas
  }

  public func preparado() -> String {
    return notas.joined(separator: " ")
  }
}

// 3
open class Instrumento {
  public let marca: String

  public init(marca: String) {
    self.marca = marca
  }

  // 4 
  open func melodia() -> String {
    fatalError("Corre este método para \(marca)")
  }

  open func tocar(_ musica: Musica) -> String {
    return musica.preparado()
  }

  // 5
  final public func presentar(_ musica: Musica) {
    print(melodia())
    print(tocar(musica))
  }
}
