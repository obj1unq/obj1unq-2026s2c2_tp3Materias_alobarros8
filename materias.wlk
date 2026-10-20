
class SinRequisitos {
  method cumple(estudiante) = true

  method asignarCarrera(carrera) {}
}

object sinRequisitos {
  method cumple(estudiante) = true

  method asignarCarrera(carrera) {}
}

class Correlativas {
  const requisitos = #{}

  method cumple(estudiante) =
    requisitos.all({ requisito => estudiante.tieneAprobada(requisito) })

  method asignarCarrera(carrera) {}
}

class RequisitoPorCreditos {
  const creditosNecesarios
  var carrera = null

  method cumple(estudiante) =
    estudiante.creditosAprobadosEn(carrera) >= creditosNecesarios

  method asignarCarrera(unaCarrera) {
    carrera = unaCarrera
  }
}

class RequisitoPorAnio {
  const anioNecesario
  var carrera = null

  method cumple(estudiante) =
    carrera.aproboAnioCompleto(estudiante, anioNecesario)

  method asignarCarrera(unaCarrera) {
    carrera = unaCarrera
  }
}

class Materia {
  const nombre
  const inscriptos = #{}
  var property requisitos = sinRequisitos
  var property creditos = 0
  var property anio = 0
  var carrera = null

  method nombre() = nombre

  method carrera() = carrera

  method asignarCarrera(unaCarrera) {
    carrera = unaCarrera
    requisitos.asignarCarrera(unaCarrera)
  }

  method inscriptos() = inscriptos

  method configurarRequisitos(nuevosRequisitos) {
    requisitos = nuevosRequisitos
    requisitos.asignarCarrera(carrera)
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

  method cumpleRequisitos(estudiante) = requisitos.cumple(estudiante)
}

class Cursada {
  const materia
  const nota

  method materia() = materia

  method nota() = nota

  method estaAprobada() = nota >= 6

  method creditosDeMateria() = materia.creditos()
}
