//
//  HomeRecipeCardModel.swift
//  Foody
//
//  Created by halil yılmaz on 7.07.2023.
//

import Foundation

class HomeRecipeCardModel {
    let title: String
    let description: String
    let recipeTime: Int
    var photoURL: String
    let materials: [String]
    let howManyPersonFor: Int
    
    init(title: String, description: String, recipeTime: Int, photoURL: String, materials: [String], howManyPersonFor: Int) {
        self.title = title
        self.description = description
        self.recipeTime = recipeTime
        self.photoURL = photoURL
        self.materials = materials
        self.howManyPersonFor = howManyPersonFor
    }
}
