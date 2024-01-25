//
//  ContentView.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 23.01.24.
//

import SwiftUI

struct ContentView: View {
    let db = BookRepository()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")	
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
