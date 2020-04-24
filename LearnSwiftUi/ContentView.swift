//
//  ContentView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//

import SwiftUI


struct ContentView: View {
    @State private var viewIndex = 0
    #if DEBUG
    var recipes = Helper.mockRecipes()
    #else
    var recipes = [RecipeModel]()
    #endif
    
    var body: some View {
        VStack {
            Picker(selection: $viewIndex, label: Text("")) {
                Text("Recipes").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            if viewIndex == 0 {
                List(recipes, id: \.id) { recipe in
                    RecipeView(recipe: recipe)
                }
            } else if viewIndex == 1 {
                List(Helper.getFavourites(), id: \.id) { recipe in
                    RecipeView(recipe: recipe)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(recipes: Helper.mockRecipes())
    }
}
