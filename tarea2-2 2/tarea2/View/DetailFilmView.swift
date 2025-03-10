//
//  DetailFilmView.swift
//  tarea2
//
//  Created by Magali Leiva on 11/2/24.
//  Practica final
//

import SwiftUI // 📌 Importamos SwiftUI para la interfaz gráfica.

struct DetailFilmView: View { // 📌 Vista que muestra los detalles de una película.
    
    let film: Result // ✅ `film` almacena los datos de la película seleccionada.

    var body: some View {
        VStack(alignment: .leading) { // ✅ Organiza los elementos en una columna alineada a la izquierda.
            
            // ✅ Muestra la imagen del póster de la película de forma asíncrona.
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/" + film.poster_path)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // 🔄 Muestra un indicador de carga mientras se descarga la imagen.
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 420) // 🔵 Establece una altura fija para la imagen.
                        .clipped() // 🔵 Recorta la imagen para que se ajuste bien al frame.
                case .failure:
                    Image(systemName: "photo") // ❌ Muestra un ícono de error si la imagen falla al cargar.
                @unknown default:
                    EmptyView() // 🔲 Vista vacía por si surge un error desconocido.
                }
            }
            
            VStack(alignment: .leading) { // ✅ Organiza los textos en una columna.
                HStack { // ✅ `HStack` alinea el título y la estrella de calificación en una fila.
                    Text(film.title)
                        .font(.system(size: 23, weight: .medium)) // 🔵 Título con tamaño y peso de fuente específicos.
                        .padding(.bottom, 1)
                    
                    Image(systemName: "star.fill") // ⭐ Muestra una estrella de calificación.
                        .foregroundColor(.gold) // 🔵 Establece el color dorado a la estrella.
                        .padding(.trailing, 10)
                    
                    Spacer() // 🔵 Empuja los elementos a la izquierda y derecha para distribuirlos mejor.
                }
                
                Text(film.release_date) // 📅 Muestra la fecha de estreno de la película.
                    .font(.subheadline)
                    .foregroundColor(.redCarpet) // 🔴 Usa un color personalizado.
                    .padding()

                Text("Sinopsis") // 🎞️ Título de la sección de sinopsis.
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.9)) // 🔵 Usa un color gris con transparencia.
                
                Text(film.overview) // 📜 Muestra la sinopsis de la película.
                    .font(.caption)
                    .multilineTextAlignment(.center) // 🔵 Centra el texto de la sinopsis.
                    .padding()

                Text("Categorías") // 🏷️ Título de la sección de categorías.
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.9))

                HStack { // ✅ Muestra los géneros de la película en una fila.
                    ForEach(film.genre_ids, id: \.self) { id in
                        Text(Genero.generos[Genero.generos.firstIndex(where: { $0.id == id })!].nombre) // 🔵 Busca el nombre del género basado en su ID.
                            .font(.caption2)
                            .padding(.all, 5)
                            .background(.gray.opacity(0.2)) // 🔵 Agrega un fondo gris con transparencia.
                            .cornerRadius(10) // 🔵 Bordes redondeados en las etiquetas de género.
                    }
                }
            }
            .padding(.top, 5)
            .padding(.horizontal, 10) // 🔵 Agrega espaciado horizontal.
            
            Spacer() // 🔵 Empuja el contenido hacia arriba para que ocupe toda la pantalla.
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // ✅ Ocupa toda la pantalla.
        .ignoresSafeArea() // 🔵 Permite que la vista use todo el espacio disponible en la pantalla.
    }
}
/*Explicación General
 DetailFilmView.swift es la vista que muestra los detalles de una película seleccionada.

 Muestra el póster de la película de forma asíncrona usando AsyncImage().

 Si la imagen está cargando, muestra un ProgressView().
 Si la imagen se carga correctamente, la muestra con resizable() y scaledToFill().
 Si la imagen falla, muestra un icono de error "photo".
 Muestra la información de la película:

 Título de la película (Text(film.title)).
 Ícono de estrella (Image(systemName: "star.fill")).
 Fecha de estreno en color rojo.
 Sinopsis de la película, con alineación centrada.
 Categorías de la película, usando etiquetas con HStack.
 Organización en la pantalla:

 Se usa VStack(alignment: .leading) para mostrar los datos ordenadamente.
 Spacer() empuja el contenido hacia arriba para una mejor distribución.
 ignoresSafeArea() permite que la vista use todo el espacio disponible en la pantalla.
 📌 Ejemplo de Flujo de la App
 1️⃣ El usuario ve la lista de películas en ContentView.swift.
 2️⃣ Selecciona una película, lo que abre DetailFilmView.swift con la información de esa película.
 3️⃣ Se carga la imagen, el título, la sinopsis y los géneros.
 4️⃣ Si la imagen no se encuentra, se muestra un icono de error.

*/

