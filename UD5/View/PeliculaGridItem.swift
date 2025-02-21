import SwiftUI

struct PeliculaGridItem: View {
    let pelicula: Peliculas
    @ObservedObject var viewModel: PeliculasViewModel
    @ObservedObject var generosViewModel: GenerosViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing){
                
                if let url = viewModel.getPosterURL(for: pelicula.posterPath) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 240)
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 10, x: 0, y: 5)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Text("Imagen no disponible")
                        .foregroundColor(.red)
                }
                
                Text(viewModel.getVoteAverege(for: pelicula.voteAverage))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(Color.red))
                    .offset(x: 20, y: -20)
            }
            VStack(alignment: .leading, spacing: 3){
                Text(pelicula.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(generosViewModel.getGenero(for: pelicula.genreIds)
                    .split(separator: ",")
                    .first?
                    .trimmingCharacters(in: .whitespaces) ?? "Sin género"
                     )//Limpia espacios extras
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(15)
                    .shadow(radius: 2)
            }
            
        }
        .padding(.horizontal, 5)
    }
}


