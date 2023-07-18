//
//  SearchModel.swift
//  Foody
//
//  Created by halil yılmaz on 13.07.2023.
//

import Foundation

struct SearchModel {
    let title: String
    let materials: [String]
    var photoURL: String
    
    init(title: String, materials: [String], photoURL: String) {
        self.title = title
        self.materials = materials
        self.photoURL = photoURL
    }
}
