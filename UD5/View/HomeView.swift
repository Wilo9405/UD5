import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PeliculasViewModel()
    @StateObject var generosViewModel = GenerosViewModel()
    let gritItems: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationStack {
            ZStack {
                Image("fondo")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                VStack {
                    HStack {
                        Image("movie")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Movies")
                            .font(.custom("PassionOne-Regular", size: 40))
                        Image("movie")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack {
                        Text("Peliculas seleccionadas")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20))
                            .bold()
                            .padding(.leading, 8)
                            .padding(.top, 10)
                            
                        TextField("Buscar Pelicula...", text: $viewModel.searchText)
                            .padding(10)
                            .background(.white)
                            .border(Color.gray)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                    }
                    ScrollView {
                        LazyVGrid(columns: gritItems, spacing: 30) {
                            ForEach(viewModel.peliculasFiltradas) { pelicula in
                                NavigationLink(destination: PeliculaDetalleView(pelicula: pelicula, viewModel: viewModel, generosViewModel: generosViewModel)) {
                                    PeliculaGridItem(pelicula: pelicula,viewModel: viewModel, generosViewModel: generosViewModel)
                            
                                }
                            }
                        }
                        .padding()
                    }
                    
                }
            }
            
        }
        .onAppear{
            viewModel.fetchPeliculas()
            generosViewModel.fetchGeneros()
        }
    }
}

