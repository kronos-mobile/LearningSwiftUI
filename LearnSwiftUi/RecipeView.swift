//
//  RecipeView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import SwiftUI

struct RecipeView: View {
    @State var recipe: RecipeModel = RecipeModel()
    
    var body: some View {
        Group {
            VStack {
                Text("\(recipe.name)")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                    .bold()
                
                //Image(recipe.countryCode)
                
                Text("\(recipe.origin)")
                    .font(.subheadline)
                    .foregroundColor(Color.purple)
                    .italic()
            }
            VStack(alignment: .trailing, spacing: 10) {
                Button(action: {
                    self.recipe.favourite.toggle()
                }) {
                    Image(systemName: self.recipe.favourite ? "star.fill" : "star")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
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
