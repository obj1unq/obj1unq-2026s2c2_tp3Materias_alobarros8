
class Materia {
  const nombre
  const inscriptos = #{}
  var requisitos = #{}

  method inscriptos() = inscriptos

  method requisitos() = requisitos

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
      self.error("El estudiante no aprobó todos los requisitos de esta materia")
    }
  }

  method perteneceAUnaCarreraDelEstudiante(estudiante) =
    estudiante.tieneMateriaEnAlgunaCarrera(self)

  method noFueAprobadaPor(estudiante) =
    !estudiante.tieneAprobada(self)

  method noEstaInscripto(estudiante) =
    !inscriptos.contains(estudiante)

  method cumpleRequisitos(estudiante) =
    requisitos.all({ requisito => estudiante.tieneAprobada(requisito) })
}

class Cursada {
  const materia
  const nota

  method materia() = materia

  method nota() = nota

  method estaAprobada() = nota >= 6
}
