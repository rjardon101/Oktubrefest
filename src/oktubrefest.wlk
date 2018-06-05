class Carpa {

	const capacidadDePersonas
	const tocaMusica
	const marcaDeCerveza
	var personasDentro = #{}

	method puedeIngresar(unaPersona) {
		return (not unaPersona.estaEbrio()) and capacidadDePersonas > personasDentro.size()
	}

	method aumentarPersonas(unaPersona) {
		personasDentro.add(unaPersona)
	}

	method cantidadDeEbriosEmpedernidos() {
		return personasDentro.count({ persona => persona.esEbrioEmpedernido() })
	}

}

class Jarra inherits Cerveza {

	const marca
	const capacidad
	var carpaDondeSeVende

	method cantidadDeAlcohol() {
		return capacidad * self.graduacion()
	}
	
	method carpaDondeSeVende(unaCarpa) {
		carpaDondeSeVende = unaCarpa
	}

}

class Persona {

	const peso
	const gustoMusical
	const aguante
	var jarrasCompradas = []
	const nacionalidad

	method leGustaLaCerveza(unaCerveza)

	method alcoholIngerido() {
		return jarrasCompradas.sum({ jarra => jarra.cantidadDeAlcohol() })
	}

	method comprarJarras(unaJarra) {
		jarrasCompradas.add(unaJarra)
	}

	method estaEbrio() {
		return aguante < self.alcoholIngerido() * peso
	}

	method quiereEntrar(unaCarpa, unaCerveza) {
		return (unaCarpa.tocaMusica() == gustoMusical) and self.leGustaLaCerveza(unaCerveza)
	}

	method puedeEntrar(unaCarpa, unaCerveza) {
		return (self.quiereEntrar(unaCarpa, unaCerveza) and unaCarpa.puedeIngresar(self))
	}

	method podriaEntrarSi(unaCarpa, unaCerveza) {
		if (not self.quiereEntrar(unaCarpa, unaCerveza)) {
			self.error("No puede entrar porque no hay capacidad o la persona está ebria")
		} else (unaCarpa.aumentarPersonas(self))
	}

	method esEbrioEmpedernido() {
		return jarrasCompradas.all({ jarra => jarra.capacidad() >= 1 })
	}

	method esPatriota() {
		return jarrasCompradas.all({ jarra => jarra.paisDeOrigen() == nacionalidad })
	}

	method enQueCarpasCompro() {
		return jarrasCompradas.map({jarras => jarras.carpaDondeSeVende()}).asSet()
	}
	
	method fueronJuntos(persona1, persona2) {
		return persona1.jarrasCompradas() == persona2.jarrasCompradas()
	}

}

class Aleman inherits Persona {

	override method quiereEntrar(unaCarpa) {
		return super(unaCarpa) and unaCarpa.capacidadDePersonas() % 2 == 0
	}

	override method leGustaLaCerveza(unaCerveza) {
		return true
	}

}

class Belga inherits Persona {

	override method leGustaLaCerveza(unaCerveza) {
		return unaCerveza.lupuloPorLitro() > 4
	}

}

class Checo inherits Persona {

	override method leGustaLaCerveza(unaCerveza) {
		return unaCerveza.graduacion() > 8
	}

}

class Cerveza {

	const clase
	const property lupuloPorLitro
	const paisDeOrigen
	var graduacionReglamentaria

	method graduacion()

}

class CervezaNegra inherits Cerveza {

	override method graduacion() {
		return graduacionReglamentaria - 2 * lupuloPorLitro
	}

}

class CercezaRubia inherits Cerveza {
	
}

class CervezaRoja inherits Cerveza {
	
}