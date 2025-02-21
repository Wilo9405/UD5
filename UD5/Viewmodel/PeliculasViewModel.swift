import Foundation

class PeliculasViewModel: ObservableObject {
    @Published var peliculas: [Peliculas] = []
    @Published var searchText: String = ""
    
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjJhZTFhN2NkMWNiN2Q2MGE4Yzg1NjMxNjRiYWQyNCIsIm5iZiI6MTcxMjc2ODk1OC42NDIsInN1YiI6IjY2MTZjN2JlYjRhNTQzMDE2MzRkMGY0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gcYmDWs8GuUQZURpAW4io03ibCeNpbzS7hUSrGACxoQ"
    var peliculasFiltradas: [Peliculas] {
        if searchText.isEmpty {
            return peliculas
        }else{
            return peliculas.filter{ peliculas in
                peliculas.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    
    func fetchPeliculas() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=es-ES&page=1") else {
            print("Error: URL inválida")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: datos nulos en la respuesta \(error.localizedDescription)")
                return
                }
            guard let data = data else {
                print("Error: datos nulos en la respuesta")
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(PeliculasResponse.self, from: data)
                 DispatchQueue.main.async {
                     self.peliculas = decodedResponse.results
            }
            
            }catch let error as NSError{
                print("Error al hacer el post", error.localizedDescription)
            }
        }.resume()
    }
    
    func getPosterURL(for postPath: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(postPath)")
    }
    func getVoteAverege(for voteAverage: Double) -> String {
        return String(format: "%.1f", voteAverage)
    }
    func getReleaseDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "No Disponible"
        }
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
        
    }
    

