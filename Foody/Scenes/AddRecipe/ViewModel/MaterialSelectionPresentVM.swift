//
//  MaterialSelectionPresentVM.swift
//  Foody
//
//  Created by halil yılmaz on 12.07.2023.
//

import Foundation

struct MaterialSelectionPresentVM {
    var selectedItems: [String] = []
    
    var materialsTools = [
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
        MaterialsModel(learnType: "Sebze", list: ["domates","biber","patlıcan","marul"]),
        MaterialsModel(learnType: "Meyve", list: ["elma","armut","karpuz","marul"]),
    ]
}
