//
//  ContentView.swift
//  Ex 01 SwiftUI
//
//  Created by septe habudin on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(movies) { movie in
                    MovieItemView(movie: movie)
                }
            }
            .navigationTitle("The Movies")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
