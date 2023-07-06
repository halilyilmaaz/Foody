//
//  UIImageView+Extension.swift
//  Foody
//
//  Created by halil yılmaz on 6.06.2023.
//

import UIKit

extension UIImageView {

   func setRounded() {
      let radius = CGRectGetWidth(self.frame) / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}


