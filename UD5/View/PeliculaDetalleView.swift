import SwiftUI

struct PeliculaDetalleView: View {
    let pelicula: Peliculas
    let viewModel: PeliculasViewModel
    @ObservedObject var generosViewModel: GenerosViewModel
    
    var body: some View {
        ScrollView{
            VStack (spacing: 0) {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(pelicula.posterPath)") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 400)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading){
                    Text(pelicula.title).font(.title).bold()
                    HStack{
                        Spacer()
                        ForEach(0..<Int(pelicula.voteAverage / 2), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 15, height: 15)
                        }
                        
                        if pelicula.voteAverage.truncatingRemainder(dividingBy: 2) >= 1.0 {
                            Image(systemName: "star.leadinghalf.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 15, height: 15)
                        }
                    }
                    .padding(.trailing)
                    .padding(.top,-20)
                    
                    Text(pelicula.releaseDate)
                        .foregroundColor(.red)
                        .padding(.top, -20)
                    Spacer()
                    
                    
                    Text("Sinopsis")
                        .bold()
                        .foregroundColor(.gray)
                    Text(pelicula.overview).padding()
                    Text("Categorias")
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack{
                        ForEach(generosViewModel.getGenero(for: pelicula.genreIds)
                            .split(separator: ","), id: \.self) { genero in
                                
                                Text(genero)
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(15)
                                    .shadow(radius: 2)
                            }
                    }
                }
                .padding(.horizontal,16)
                .padding(.top, 10)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
        
        
    }
}
