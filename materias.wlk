
class SinRequisitos {
  method cumple(materia, estudiante) = true
}

object sinRequisitos {
  method cumple(materia, estudiante) = true
}

class Correlativas {
  const requisitos = #{}

  method cumple(materia, estudiante) =
    requisitos.all({ requisito => estudiante.tieneAprobada(requisito) })
}

class RequisitoPorCreditos {
  const creditosNecesarios

  method cumple(materia, estudiante) =
    estudiante.creditosAprobadosEn(materia.carrera()) >= creditosNecesarios
}

class RequisitoPorAnio {
  const anioNecesario

  method cumple(materia, estudiante) =
    estudiante.aproboAnioCompleto(materia.carrera(), anioNecesario)
}

class Materia {
  const nombre
  const inscriptos = #{}
  var property requisitos = sinRequisitos
  var property creditos = 0
  var property anio = 0
  var carrera = null

  method carrera() = carrera

  method asignarCarrera(unaCarrera) {
    carrera = unaCarrera
  }

  method inscriptos() = inscriptos

  method configurarRequisitos(nuevosRequisitos) {
    
      requisitos = nuevosRequisitos
    
  }

  method puedeInscribirse(estudiante) =
    self.perteneceAUnaCarreraDelEstudiante(estudiante) &&
      self.noFueAprobadaPor(estudiante) &&
      self.noEstaInscripto(estudiante) &&
      self.cumpleRequisitos(estudiante)

  method inscribir(estudiante) {
    self.validarInscripcion(estudiante)
    inscriptos.add(estudiante)
  }

  method validarInscripcion(estudiante) {
    if (!self.perteneceAUnaCarreraDelEstudiante(estudiante)) {
      self.error("La materia no pertenece a ninguna carrera en la que está inscripto el estudiante")
    }
    if (!self.noFueAprobadaPor(estudiante)) {
      self.error("El estudiante ya aprobó esta materia")
    }
    if (!self.noEstaInscripto(estudiante)) {
      self.error("El estudiante ya está inscripto en esta materia")
    }
    if (!self.cumpleRequisitos(estudiante)) {
      self.error("El estudiante no cumple los requisitos de esta materia")
    }
  }

  method perteneceAUnaCarreraDelEstudiante(estudiante) =
    estudiante.tieneMateriaEnAlgunaCarrera(self)

  method noFueAprobadaPor(estudiante) =
    !estudiante.tieneAprobada(self)

  method noEstaInscripto(estudiante) =
    !inscriptos.contains(estudiante)

  method cumpleRequisitos(estudiante) {
    if (requisitos == sinRequisitos) return true
    if (requisitos.className().contains("Set")) {
      return requisitos.all({ requisito => estudiante.tieneAprobada(requisito) })
    }
    return requisitos.cumple(self, estudiante)
  }
}

class Cursada {
  const materia
  const nota

  method materia() = materia

  method nota() = nota

  method estaAprobada() = nota >= 6

  method creditosDeMateria() = materia.creditos()
}
