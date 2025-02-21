
import Foundation

struct Peliculas: Identifiable, Decodable {
    let id : Int
    let title : String
    let posterPath : String
    let voteAverage : Double
    let overview : String
    let releaseDate : String
    let genreIds : [Int]
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path", voteAverage = "vote_average", releaseDate = "release_date", genreIds = "genre_ids"
        
    }
}
