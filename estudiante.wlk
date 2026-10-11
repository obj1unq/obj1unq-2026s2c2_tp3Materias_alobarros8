import materias.*
import carrera.*
class Estudiante {
  const nombre
  const carreras = #{}
  const cursadas = []

  method inscribirEn(carrera) {
    self.validarNoInscriptaEn(carrera)
    carreras.add(carrera)
  }

  method validarNoInscriptaEn(carrera) {
    if (carreras.contains(carrera)) {
      self.error("La persona estudiante ya está inscripta en esta carrera")
    }
  }

  method carreras() = carreras

  method estaInscriptaEn(carrera) = carreras.contains(carrera)

  method tieneMateriaEnAlgunaCarrera(materia) =
    carreras.any({ carrera => carrera.tieneMateria(materia) })

  method puedeInscribirseA(materia) =
    materia.puedeInscribirse(self)

  method inscribirseA(materia) {
    materia.inscribir(self)
  }

  method creditosAprobadosEn(carrera) =
    self.cursadasAprobadas().filter({ cursada => carrera.tieneMateria(cursada.materia()) })
      .sum({ cursada => cursada.materia().creditos() })

  method aproboAnioCompleto(carrera, anio) =
    carrera.materiasDelAnio(anio).all({ materia => self.tieneAprobada(materia) })

  method registrarCursada(materia, nota) {
    self.validarNota(nota)
    self.validarMateriaNoAprobada(materia)
    self.validarMateriaDeAlgunaCarrera(materia)
    cursadas.add(new Cursada(materia = materia, nota = nota))
  }

  method validarNota(nota) {
    if (!nota.between(1, 10)) {
      self.error("La nota debe estar entre 1 y 10")
    }
  }

  method validarMateriaNoAprobada(materia) {
    if (self.tieneAprobada(materia)) {
      self.error("La persona estudiante ya aprobó esta materia")
    }
  }

  method validarMateriaDeAlgunaCarrera(materia) {
    if (!self.tieneMateriaEnAlgunaCarrera(materia)) {
      self.error("La materia no pertenece a ninguna carrera en la que está inscripta")
    }
  }

  method tieneAprobada(materia) =
    self.cursadasDe(materia).any({ cursada => cursada.estaAprobada() })

  method cursadasDe(materia) =
    cursadas.filter({ cursada => cursada.materia() == materia })

  method cursadasAprobadas() =
    cursadas.filter({ cursada => cursada.estaAprobada() })

  method cursadasAprobadasEn(carrera) =
    self.cursadasAprobadas().filter({ cursada => carrera.tieneMateria(cursada.materia()) })

  method cantidadAprobadasEn(carrera) {
    self.validarInscriptaEn(carrera)
    self.validarTieneAprobadasEn(carrera)
    return self.cursadasAprobadasEn(carrera).size()
  }

  method promedioEn(carrera) {
    self.validarInscriptaEn(carrera)
    self.validarTieneAprobadasEn(carrera)
    return self.cursadasAprobadasEn(carrera).sum({ cursada => cursada.nota() }) /
      self.cursadasAprobadasEn(carrera).size()
  }

  method validarInscriptaEn(carrera) {
    if (!self.estaInscriptaEn(carrera)) {
      self.error("La persona estudiante no está inscripta en esta carrera")
    }
  }

  method validarTieneAprobadasEn(carrera) {
    if (self.cursadasAprobadasEn(carrera).isEmpty()) {
      self.error("La persona estudiante no tiene materias aprobadas en esta carrera")
    }
  }

  method cantidadAprobadas() = self.cursadasAprobadas().size()

  method promedioGeneral() {
    self.validarTieneAprobadas()
    return self.cursadasAprobadas().sum({ cursada => cursada.nota() }) /
      self.cursadasAprobadas().size()
  }

  method validarTieneAprobadas() {
    if (self.cursadasAprobadas().isEmpty()) {
      self.error("La persona estudiante no tiene materias aprobadas")
    }
  }

  method cursadas() = cursadas
}