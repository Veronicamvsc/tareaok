import Foundation // 📌 Importamos Foundation para manejar JSON y estructuras de datos.

struct Film: Codable { // 📌 `Film` representa la respuesta principal de la API con varias películas.
    let page: Int // ✅ Página actual de los resultados (para paginación).
    let results: [Result] // ✅ Lista de películas (`Result` es el modelo de cada película).
    let total_pages, total_results: Int // ✅ Número total de páginas y resultados disponibles en la API.
}

struct Result: Codable { // 📌 `Result` representa una película individual en la API.
    let adult: Bool // ✅ Indica si la película es solo para adultos (`true` o `false`).
    let backdrop_path: String // ✅ Ruta de la imagen de fondo de la película.
    let genre_ids: [Int] // ✅ Lista de IDs de los géneros asociados a la película.
    let id: Int // ✅ Identificador único de la película.
    let original_language: String // ✅ Idioma original de la película (ej. "en", "es").
    let original_title: String // ✅ Título original de la película.
    let overview: String // ✅ Resumen o sinopsis de la película.
    let popularity: Double // ✅ Nivel de popularidad de la película.
    let poster_path: String // ✅ Ruta de la imagen del póster de la película.
    let release_date: String // ✅ Fecha de estreno de la película en formato `YYYY-MM-DD`.
    let title: String // ✅ Título en el idioma actual de la API.
    let video: Bool // ✅ Indica si la película tiene una versión en video disponible (`true` o `false`).
    let vote_average: Double // ✅ Calificación promedio de la película (ej. `7.8`).
    let vote_count: Int // ✅ Número total de votos recibidos por la película.
}

/*Explicación General
Este código define dos estructuras de datos Film y Result que representan la respuesta de una API de películas, probablemente The Movie Database (TMDb).

Film

Contiene la información de la página actual (page).
Tiene una lista de resultados (results), que son las películas obtenidas.
Contiene total_pages y total_results, que indican cuántas películas hay en total.
Result

Contiene todos los detalles de una película individual.
Tiene información sobre el título, sinopsis, popularidad, fecha de estreno y calificación.
También incluye imágenes (backdrop_path, poster_path) y si la película es solo para adultos (adult). */
