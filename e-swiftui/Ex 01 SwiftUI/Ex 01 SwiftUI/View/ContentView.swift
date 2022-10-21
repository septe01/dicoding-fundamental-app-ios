//
//  ContentView.swift
//  Ex 01 SwiftUI
//
//  Created by septe habudin on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var myMovies: [Movie] = []
    @State var isLoading = true
    @State var isError = false

    var body: some View {
        NavigationView(content: {
            if isLoading {
                ProgressView()
                Text("Sedang memuat data...")
                    .padding()
            } else {
                List {
                    ForEach(movies) { movie in
                        MovieItemView(movie: movie)
                    }
                }
                .navigationTitle("The Movies")
            }
        })
        // SwiftUI menyediakan modifier task untuk menjalankan proses async/await
        .task {
            let movieViewModel = MovieViewModel()
            isLoading = true
            do {
                self.myMovies = try await movieViewModel.getMovies()
                isLoading = false
                isError = false
            } catch {
                isLoading = false
                isError = true
                print("Error")
            }
        }
        .alert("Gagal memuat data!", isPresented: $isError) {
              Button("OK", role: .cancel) {}
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
