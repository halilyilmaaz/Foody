//
//  SearchViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//

import Foundation

struct SearchViewModel {
    var selectedItems: Set<String> = []
    
    var materialsTool = [
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
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
