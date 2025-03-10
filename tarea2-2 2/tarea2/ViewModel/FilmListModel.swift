//
//  FilmListModel.swift
//  tarea2
//
//  Created by Magalí Leiva on 11/2/24.
//

import Foundation // 📌 Importamos Foundation para manejar la red y la decodificación JSON.

class FilmListModel: ObservableObject { // 📌 `FilmListModel` sigue el patrón MVVM y maneja la obtención de películas desde una API.
    
    @Published var films: [Result] = [] // ✅ `@Published` permite actualizar la vista automáticamente cuando `films` cambia.

    init() { // ✅ `init()` se ejecuta automáticamente cuando se crea una instancia de `FilmListModel`.
        obtenerDatos() // 🔵 Llama a `obtenerDatos()` para obtener las películas desde la API.
    }

    func obtenerDatos() { // 📌 `obtenerDatos()` hace una solicitud HTTP para obtener las películas mejor valoradas.
        
        // ✅ Configuración de los encabezados HTTP.
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer " // ❌ Falta el Token de autenticación aquí.
        ]

        // ✅ Configuración de la URL de la API (top-rated movies en español, página 1).
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?language=es-ES&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0) // ⏳ Define un tiempo de espera de 10 segundos.
        
        request.httpMethod = "GET" // ✅ Especifica que la petición es de tipo GET.
        request.allHTTPHeaderFields = headers // ✅ Asigna los encabezados a la solicitud.

        // ✅ Inicia una tarea de red para obtener los datos.
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, _ in
            
            guard let data = data else { return } // ❌ Si no hay datos, se detiene la ejecución.

            do {
                print(String(data: data, encoding: .utf8)!) // 📜 Imprime la respuesta JSON en formato texto.

                // ✅ Decodifica los datos JSON en un objeto `Film` usando `JSONDecoder()`.
                let datos = try JSONDecoder().decode(Film.self, from: data)
                
                // ✅ Actualiza `films` en el hilo principal para que la UI se actualice.
                DispatchQueue.main.async {
                    self.films = datos.results
                    print(self.films) // 🔵 Imprime la lista de películas en consola.
                }
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context) // ❌ Muestra un error si el JSON está corrupto.
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription) // ❌ Muestra un error si falta una clave en el JSON.
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription) // ❌ Error si no encuentra un valor esperado.
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription) // ❌ Error si el tipo de dato no coincide con el esperado.
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error) // ❌ Captura cualquier otro error desconocido.
            }
        }.resume() // ✅ Inicia la tarea de red para obtener los datos de la API.
    }
}
/*Explicación General
 Este FilmListModel.swift es un ViewModel en MVVM que maneja la obtención de películas desde la API de The Movie Database (TMDb).

 @Published var films: [Result] = []

 Guarda la lista de películas obtenidas desde la API.
 Cuando se actualiza, SwiftUI actualiza la vista automáticamente.
 Función obtenerDatos()

 Hace una petición HTTP GET a https://api.themoviedb.org/3/movie/top_rated?language=es-ES&page=1.
 Usa URLSession para realizar la solicitud.
 Decodifica el JSON en Film, que contiene una lista de películas (results).
 Si hay un error en la decodificación, lo imprime en consola.
 Actualización en el hilo principal (DispatchQueue.main.async)

 Como las peticiones de red se ejecutan en segundo plano, los datos deben actualizarse en el hilo principal para que SwiftUI pueda reflejar los cambios en la UI.
 Manejo de errores

 Si el JSON es inválido o los datos son incorrectos, se imprimen errores detallados en consola.
 lujo de la Aplicación
 1️⃣ FilmListModel se inicializa en ContentView.swift.
 2️⃣ Se ejecuta obtenerDatos(), que hace la petición HTTP.
 3️⃣ Si la API responde correctamente, los datos se decodifican en Film.
 4️⃣ films se actualiza en DispatchQueue.main.async para reflejar los datos en la UI.
 5️⃣ SwiftUI actualiza automáticamente ContentView.swift mostrando las películas.*/
