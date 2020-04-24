//
//  RecipeView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import SwiftUI

struct RecipeView: View {
    var recipe: RecipeModel = RecipeModel()
    
    var body: some View {
        
        VStack {
            Text("\(recipe.name)")
                .font(.headline)
                .foregroundColor(Color.blue)
                .bold()
            Text("\(recipe.origin)")
                .font(.subheadline)
                .foregroundColor(Color.purple)
                .italic()
        }
         
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecipeView(recipe: RecipeModel(id: UUID(), name: "Italian Pizza Chicken", origin: "Italian"))
        }
    }
}
