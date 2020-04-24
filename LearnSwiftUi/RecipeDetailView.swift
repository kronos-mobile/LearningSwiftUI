//
//  RecipeDetailView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import SwiftUI

struct RecipeDetailView: View {
    
//    @State var recipe: RecipeModel!
    @State var recipe = Helper.mockRecipes().first!
    @State private var viewIndex = 0
    
    private var isFavourite: Bool {
        return recipe.favourite
//        return Helper.getFavourites().contains(where: {($0.name == recipe.name)})
    }
    
    
    var body: some View {
        // VStack so we can list our components vertically
        VStack(alignment: .leading, spacing: 15) {
            
            // Image (currently using flag)
//            Image(recipe.countryCode)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(maxWidth: .infinity, maxHeight: 200)
            
            HStack {
                // Name of our recipe
                Text("\(recipe.name)")
                    .font(.title)
                    .padding(.leading, 10)
                
                // Favourites Button
                Button(action: {
                    Helper.addRemoveFavourite(recipe: self.recipe)
                    self.recipe.favourite.toggle()
                }) {
                    Image(systemName: isFavourite ? "star.fill" : "star")
                }
                
            }
            
            // Recipe origin
            Text("Origin: \(recipe.origin)")
                .font(.subheadline)
                .padding(.leading, 10)
            
        
            // Picker to choose between Igredients & Recipe
            Picker(selection: $viewIndex, label: Text("")) {
                Text("Ingredients").tag(0)
                Text("Recipe").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            // Logic to determin which Picker View to show.
            if viewIndex == 0 {
                List(recipe.ingredients, id: \.self) { ingredient in
                    Image(systemName: "hand.point.right")
                    Text(ingredient)
                }
                .listStyle(GroupedListStyle())
            } else if viewIndex == 1 {
                Text(recipe.recipe)
                    .padding(15)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
    }
    
    
}

struct RecipeDetailView_Previews: PreviewProvider {

    static var previews: some View {
        RecipeDetailView(recipe: Helper.mockRecipes().first!)
    }
}
