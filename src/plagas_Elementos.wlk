class Hogar {
	var property nivelMugre = 0
	var property confort = 0
	
	method esBueno() {return self.nivelMugre() <= self.confort() / 2}
	
	method recibeAtaque(plaga) {nivelMugre += plaga.nivelDeDanio()}
}

class Huerta {
	var property capacidadProduccion
	var property nivel
	
	method esBueno() {return self.capacidadProduccion() >= self.nivel() }
	
	method recibeAtaque(plaga) {
		capacidadProduccion = plaga.nivelDeDanio() * 0.10
		if (plaga.transmiteEnfermedades()) { capacidadProduccion -= 10 } }
	}


class Mascota {
	var property nivelDeSalud = 0
	
	method esBueno() {return self.nivelDeSalud() > 250}	
	
	method recibeAtaque(plaga) {if (plaga.transmiteEnfermedades()) {nivelDeSalud -= plaga.nivelDeDanio()} 
	}
}

class Barrio {
	const barrio = []
	
	method agregar(elemento) {barrio.add(elemento)}
	
	method quitar(elemento) {barrio.remove(elemento)}
	
	method cantElementosBuenos() {return barrio.count({elemento => elemento.esBueno()}) }
	
	method cantElementosMalos() {return barrio.count({elemento => not elemento.esBueno()})}
	
	method esCopado() {return self.cantElementosBuenos() > self.cantElementosMalos()}
}

