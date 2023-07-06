//
//  WrapView.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//

import Foundation
import UIKit

class WrapView: UIView {
    
    private var arrangedSubviews: [UIView] = []
    private var spacing: CGFloat = 8.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateArrangedSubviews()
    }
    
    func addArrangedSubview(_ view: UIView) {
        arrangedSubviews.append(view)
        addSubview(view)
        setNeedsLayout()
    }
    
    func setSpacing(_ spacing: CGFloat) {
        self.spacing = spacing
        setNeedsLayout()
    }
    
    private func updateArrangedSubviews() {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        let maxWidth = bounds.width
        
        for subview in arrangedSubviews {
            let subviewSize = subview.bounds.size
            
            if currentX + subviewSize.width > maxWidth {
                currentX = 0
                currentY += subviewSize.height + spacing
            }
            
            subview.frame = CGRect(x: currentX, y: currentY, width: subviewSize.width, height: subviewSize.height)
            currentX += subviewSize.width + spacing
        }
        
//        bounds.size.height = currentY + subviewSize.height
    }
}
