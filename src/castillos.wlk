class Castillo{
	var estabilidad 
	const ambientes = []
	const guardias = []
	const burocratas = []
	const largoMuralla 
	method derrota() = estabilidad < 100
	
	method estabilidad() = estabilidad

	method agregarAmbientes(largoAmbiente){
		ambientes.add(new Ambiente(largo = largoAmbiente))
	} 
	
	method agregarGuardias(capacidadGuardia){
		guardias.add(new Guardia(capacidad = capacidadGuardia))
	}
	
	method resistencia() {
		return largoMuralla + ambientes.size() + guardias.count({guardia => guardia.capacidad() > 10}) 
		// la resistencia depende del largo de la muralla + la cantidad de ambientes + cantidad de guardias con más de 10 de capacidad
	}
	
	method burocratas() = burocratas
	
	method preparDefensas() {
		estabilidad += guardias.size() + burocratas.forEach({burocrata => burocrata.planDefensa()}) //La suma de la cantidad de los guardias más el plan de los burocratas
	}
	
	method noHayTemor() = ((burocratas.count({burocrata => burocrata.temor()}) / burocrata.size()) * 100) < 50
	
	method fiesta(){
		return (estabilidad > 125 and self.noHayTemor())
	}
	
	method agregarBurocrata(burocrata){
		burocratas.add(burocrata)
	}
	
	method atacar(tiempo) {
		// cuando atacan al castillo todos los burocratas con menos de 10 años de experencia o 20 años de edad se asustan
		// los guardias aumentan su agotamiento en 10 * tiempo de combate
		guardias.forEach({guardia => guardia.aumentarAgotamiento(tiempo)})
		burocratas.forEach({burocrata => burocrata.asustar()})
		estabilidad -= self.resistencia() * tiempo // pierde su resistencia * tiempo de combate
	}
}

class Guardia{
	const capacidad 
	var agotamiento = 0
	
	method capacidad() = capacidad 
	
	method Aumentaragotamiento(tiempo) {
		agotamiento += 10 * tiempo 
	}
}


class Burocrata{
	var temor = false
	const fechaNacimiento 
	const aniosExperencia
	
	method edad() {
		return 2021 - fechaNacimiento 
	}
	
	method planDefensa() = 5 + aniosExperencia
	
	method temor() = temor
	
	method reiniciarTemor() {
		temor = false
	}
	
	method asustar(){
		if (aniosExperencia < 10 or self.edad() < 20 ) {
			temor = true
		}
	}
	
}

class Ambiente{
	var largo
	
	method largo() = largo
}

object rey{
	const castilloRey = new Castillo(estabilidad = 200, largoMuralla = 10)
	
	
	method hacerFiesta(){
		if (castilloRey.fiesta()) {
			castilloRey.burocratas().forEach({burocrata => burocrata.reiniciarTemor()})
		}
	}
	
	method atacar(tiempo){
		todoCastillos.sePuedeAtacar().max({castillo => castillo.estabilidad()}).atacar(tiempo) // ataca al castillo con más estabilidad
	}
}

object todoCastillos{
	const castillos = []
	
	method crearCastillo(estabilidad, largo){
		castillos.add(new Castillo(estabilidad = estabilidad, largoMuralla = largo))
	}
	
	method sePuedeAtacar() = return castillos.filter({ castillo => not castillo.derrota()})
}