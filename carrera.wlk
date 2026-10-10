import materias.*
class Carrera {
  const nombre
  const materias = #{}

  method agregarMateria(materia) {
    materias.add(materia)
  }

  method tieneMateria(materia) = materias.contains(materia)

  method materias() = materias
}