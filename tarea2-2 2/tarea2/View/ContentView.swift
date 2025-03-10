import SwiftUI // 📌 Importamos SwiftUI para construir la interfaz gráfica.

struct ContentView: View { // 📌 `ContentView` es la vista principal donde se muestran las películas.
    
    @StateObject var data = FilmListModel() // ✅ `@StateObject` crea una instancia del ViewModel que maneja la lista de películas.
    @State private var stringBuscar: String = "" // ✅ Variable de estado para la barra de búsqueda.
    
    // ✅ `gridItem` define un layout de 2 columnas para el `LazyVGrid`.
    let gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        
        // ✅ `filmFilters` almacena la lista de películas filtradas según el texto ingresado en `stringBuscar`.
        var filmFilters: [Result] {
            if stringBuscar.isEmpty {
                return data.films // 🔵 Si no hay búsqueda, muestra todas las películas.
            } else {
                return data.films.filter { $0.title.lowercased().contains(stringBuscar.lowercased()) } // 🔍 Filtra por título.
            }
        }
        
        NavigationStack { // ✅ `NavigationStack` permite navegar a detalles de cada película.
            VStack { // ✅ `VStack` organiza los elementos en una columna.
                
                // ✅ Título principal.
                Text("🎬 Movies 🎬")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                // ✅ Barra de búsqueda.
                TextField("Buscar película", text: $stringBuscar)
                    .padding()
                    .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1) // 🔲 Agrega un borde gris alrededor del campo de texto.
                    )
                    .padding()
                
                // ✅ Texto indicando que se muestran las películas mejor valoradas.
                Text("Películas mejor valoradas")
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            
                // ✅ `ScrollView` permite desplazarse por la lista de películas.
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 5) { // ✅ Muestra películas en un grid de 2 columnas.
                        ForEach(filmFilters, id:\.id) { film in
                            Item(film: film) // 🔵 Muestra cada película con el diseño del componente `Item`.
                        }
                    }
                }
            }
            .background(Image("fondo") // ✅ Establece una imagen de fondo.
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.08) // 🔵 Da un efecto de transparencia al fondo.
            )
        }
    }
}
struct Item: View {
    let film: Result // ✅ `film` contiene la información de una película.
    
    var body: some View {
        ZStack { // ✅ `ZStack` permite superponer elementos (imagen, título, género y calificación).

            VStack(alignment: .leading) { // ✅ `VStack` organiza los elementos de la película en columna.
                
                // ✅ `NavigationLink` permite navegar a `DetailFilmView` cuando se toca la película.
                NavigationLink(destination: DetailFilmView(film: film)) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/"+film.poster_path)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView() // 🔄 Muestra un indicador de carga mientras se descarga la imagen.
                                .frame(width: 170)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170)
                                .cornerRadius(10) // 🔵 Agrega bordes redondeados.
                        case .failure(_): // ❌ Si hay un error cargando la imagen.
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/"+film.poster_path)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 170)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170)
                                        .cornerRadius(10)
                                case .failure(let failure):
                                    let _ = print(failure.localizedDescription) // 🛠 Imprime el error en consola.
                                    Image("filmerror") // 🔵 Muestra una imagen de error si falla la carga.
                                        .scaledToFill()
                                        .frame(width: 170)
                                        .cornerRadius(10)
                                @unknown default:
                                    EmptyView()
                                        .frame(width: 170)
                                }
                            }
                        @unknown default:
                            EmptyView()
                                .frame(width: 170)
                        }
                    }
                }
                    
                Text(film.title) // ✅ Muestra el título de la película.
                    .font(.subheadline)
                    
                // ✅ Muestra el género de la película basado en el primer `genre_id`.
                Text(Genero.generos[Genero.generos.firstIndex(where: { $0.id == film.genre_ids[0] })!].nombre)
                    .font(.caption2)
                    .padding(.all, 5)
                    .background(.gray.opacity(0.2)) // 🔵 Agrega un fondo gris al género.
                    .cornerRadius(10)
            }
            .padding()
                
            // ✅ Muestra un círculo rojo con la calificación en la esquina superior derecha.
            Circle()
                .fill(.redCarpet) // 🔴 Color personalizado.
                .frame(width: 30)
                .position(CGPoint(x: 180, y: 15))
            
            Text("\(String(describing: Double(round(10 * film.vote_average) / 10)))") // ✅ Redondea la calificación a 1 decimal.
                .font(.caption)
                .position(CGPoint(x: 180, y: 15))
                .foregroundColor(.white) // 🔵 Color blanco para el texto.
        }
    }
}
/*Explicación General
 ContentView.swift:

 Muestra una lista de películas en una cuadrícula de 2 columnas.
 Incluye una barra de búsqueda para filtrar películas por título.
 Carga las películas desde FilmListModel() (ViewModel).
 Permite navegar a DetailFilmView cuando se selecciona una película.
 Item.swift:

 Muestra cada película con su imagen, título y género.
 Muestra un indicador de carga (ProgressView) mientras se descarga la imagen.
 Si falla la descarga, muestra una imagen de error.
 Incluye una etiqueta roja con la calificación de la película.
 Al tocar la película, se navega a DetailFilmView.
 📌 Ejemplo de Flujo de la App
 1️⃣ El usuario abre la app y se muestra ContentView.swift.
 2️⃣ FilmListModel carga la lista de películas desde la API.
 3️⃣ El usuario puede buscar películas escribiendo en la barra de búsqueda.
 4️⃣ Se muestran las películas mejor valoradas en una cuadrícula de 2 columnas.
 5️⃣ Al tocar una película, se abre DetailFilmView.swift con más información.*/
