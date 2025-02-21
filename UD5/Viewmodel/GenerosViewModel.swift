

import Foundation

class GenerosViewModel : ObservableObject {
    @Published var generos: [Generos] = []
    
    
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjJhZTFhN2NkMWNiN2Q2MGE4Yzg1NjMxNjRiYWQyNCIsIm5iZiI6MTcxMjc2ODk1OC42NDIsInN1YiI6IjY2MTZjN2JlYjRhNTQzMDE2MzRkMGY0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gcYmDWs8GuUQZURpAW4io03ibCeNpbzS7hUSrGACxoQ"
    
    func fetchGeneros() {
        guard let url = URL (string: "https://api.themoviedb.org/3/genre/movie/list?language=es-ES") else {
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
                let decodedResponse = try JSONDecoder().decode(GenerosResponse.self, from: data)
                 DispatchQueue.main.async {
                     self.generos = decodedResponse.genres
            }
            
            }catch let error as NSError{
                print("Error al hacer el post", error.localizedDescription)
            }
        }.resume()
    }
    func getGenero(for genreIds: [Int]) -> String {
        let nombres = genreIds.compactMap{ id in
            generos.first(where: { $0.id == id})?.name
        }
    return nombres.isEmpty ? "Sin genero" : nombres.joined(separator: ", ")
    }
    
    func getTodosGeneros(for genreIds: [Int]) -> String {
        let nombres = genreIds.compactMap{ id in
            generos.filter { $0.id == id }.first?.name 
        }
        return nombres.isEmpty ? "Sin genero" : nombres.joined(separator: ", ")
    }
}
