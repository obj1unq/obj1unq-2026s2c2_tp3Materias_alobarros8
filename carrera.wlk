import materias.*
class Carrera {
  const nombre
  const materias = #{}

  method agregarMateria(materia) {
    materias.add(materia)
    materia.asignarCarrera(self)
  }

  method tieneMateria(materia) = materias.contains(materia)

  method materias() = materias

  method materiasHabilitadasPara(estudiante) =
    materias.filter({ materia => estudiante.puedeInscribirseA(materia) })

  method materiasDelAnio(anio) =
    materias.filter({ materia => materia.anio() == anio })

  method aproboAnioCompleto(estudiante, anio) =
    self.materiasDelAnio(anio).all({ materia => estudiante.tieneAprobada(materia) })
}