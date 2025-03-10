import Foundation // 📌 Importamos Foundation porque usamos estructuras de datos en Swift.

struct Genero { // 📌 Definimos una estructura `Genero` que representa un género de película.
    var id: Int // ✅ Identificador único del género (según la API).
    var nombre: String // ✅ Nombre del género (en español).
}

// 📌 Extendemos la estructura `Genero` para agregar una lista estática de géneros de películas.
extension Genero {
    static var generos = [ // ✅ Lista estática de géneros con sus respectivos IDs y nombres.
        Genero(id: 28, nombre: "Acción"),
        Genero(id: 12, nombre: "Aventura"),
        Genero(id: 16, nombre: "Animación"),
        Genero(id: 35, nombre: "Comedia"),
        Genero(id: 80, nombre: "Crimen"),
        Genero(id: 99, nombre: "Documental"),
        Genero(id: 18, nombre: "Drama"),
        Genero(id: 10751, nombre: "Familia"),
        Genero(id: 14, nombre: "Fantasía"),
        Genero(id: 36, nombre: "Historia"),
        Genero(id: 27, nombre: "Terror"),
        Genero(id: 10402, nombre: "Música"),
        Genero(id: 9648, nombre: "Misterio"),
        Genero(id: 10749, nombre: "Romance"),
        Genero(id: 878, nombre: "Ciencia ficción"),
        Genero(id: 10770, nombre: "Película de TV"),
        Genero(id: 53, nombre: "Suspense"),
        Genero(id: 10752, nombre: "Bélica"),
        Genero(id: 37, nombre: "Western")
    ]
}
/* Explicación General
 Este código define una estructura Genero que representa los géneros de películas con dos propiedades:

 id → Identificador del género (según la API de TMDb).
 nombre → Nombre del género en español.
 Además, se usa una extensión (extension Genero) para agregar una propiedad estática generos, que contiene una lista predefinida de los géneros con sus respectivos IDs.

 📌 ¿Para qué sirve este código?
 Permite mapear los IDs de los géneros devueltos por la API a su nombre en español.
 Se puede usar para mostrar los géneros en la interfaz de usuario sin necesidad de hacer otra petición a la API.
 Optimiza el rendimiento, ya que evita descargar la lista de géneros cada vez que se consulte una película.*/
