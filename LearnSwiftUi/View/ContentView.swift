//
//  ContentView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = PostViewModel()
    
    var body: some View {
        List(model.articles) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                Text(article.description)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
