//
//  UIPageControl+Extension.swift
//  Foody
//
//  Created by halil yılmaz on 20.06.2023.
//

import UIKit

extension UIPageControl {
    var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }
}
