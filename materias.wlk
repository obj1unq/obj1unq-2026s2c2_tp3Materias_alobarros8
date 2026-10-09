class Estudiante {
  const nombre
  const carreras = #{}

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
}

class Carrera {
  const nombre
  const materias = #{}

  method agregarMateria(materia) {
    materias.add(materia)
  }

  method tieneMateria(materia) = materias.contains(materia)

  method materias() = materias
}

class Materia {
  const nombre
}
