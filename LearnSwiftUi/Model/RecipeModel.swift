//
//  RecipeModel.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/24/20.
//
import UIKit

struct RecipeModel: Identifiable, Hashable {
    var id = UUID()
    var name = ""
    var origin = ""
    var favourite = false
}
