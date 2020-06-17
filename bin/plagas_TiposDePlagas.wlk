import plagas_Elementos.*

class Plagas {
	var property poblacion = 0 
	
	method transmiteEnfermedades() {return self.poblacion() >= 10}
	
	method atacarA(elemento) {
		elemento.recibeAtaque(self)
		poblacion += poblacion  * 0.10
	}
}

class Cucaracha inherits Plagas{
	var property pesoPromedio = 0
	
	method nivelDeDanio() {return if (self.pesoPromedio() >= 10 and self.transmiteEnfermedades()) {poblacion / 2} else {0} }
	
	override method transmiteEnfermedades() {
		return super() and self.pesoPromedio() >= 10
	}
	
	override method atacarA(elemento) {
		super(elemento)
		pesoPromedio += 2
	}
}

class Mosquito inherits Plagas {
	method nivelDeDanio() {return self.poblacion()}
	
	override method transmiteEnfermedades() {
		return super() and self.poblacion() % 3 == 0
	}
}

class Pulga inherits Plagas {
	method nivelDeDanio() {return self.poblacion() * 2}
}

class Garrapata inherits Pulga {
	
	override method atacarA(elemento) {
		elemento.recibeAtaque(self)
		poblacion += poblacion * 0.20
	}
}