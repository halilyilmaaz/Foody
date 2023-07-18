//
//  SearchViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//
import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFetchRecipes(recipes: [HomeRecipeCardModel], error: Error?)
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    var selectedItems: [String] = []
    var searchResults: [HomeRecipeCardModel] = []
    var didFetchSearchRecipies: (([HomeRecipeCardModel]?, Error?) -> Void)?
    
    
    var searchResultsbyMaterial: [HomeRecipeCardModel] = []
    
    func searchRecipesByMaterial(withKeyword keyword: [String]) {
        SearchService.shared.searchRecipesByMaterials(materials: keyword) { [weak self] (recipes, error) in
            if let error = error {
                print("Error searching recipes: \(error)")
                return
            } else if let recipes = recipes {
                self?.searchResults = recipes ?? []
                self?.didFetchSearchRecipies?(recipes,nil)
                print("Search results: \(recipes)")
            }
        }
    }
    
    func searchRecipes(withKeyword keyword: String) {
        SearchService.shared.searchRecipes(withKeyword: keyword) { [weak self] (recipes, error) in
            self?.delegate?.didFetchRecipes(recipes: recipes ?? [], error: error)
        }
    }

    
    var materialsTool = [
        MaterialsModel(learnType: "Sebze", list: ["a","biber","b","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","a","karpuz","b"]),
        MaterialsModel(learnType: "Meyve", list: ["a","b","a","b"]),
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
    ]
}

class MaterialsModel {
    let learnType: String
    let list: [String]
    
    init(learnType: String, list: [String]) {
        self.learnType = learnType
        self.list = list
    }
}
