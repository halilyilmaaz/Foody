//
//  UITextField+Extension.swift
//  Foody
//
//  Created by halil yılmaz on 10.06.2023.
//

import UIKit

extension UITextField {
    
    func togglePasswordVisibility() {
            isSecureTextEntry = !isSecureTextEntry

            if let existingText = text, isSecureTextEntry {
                deleteBackward()

                if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                    replace(textRange, withText: existingText)
                }
            }

            if let existingSelectedTextRange = selectedTextRange {
                selectedTextRange = nil
                selectedTextRange = existingSelectedTextRange
            }
        }
    
    
//    func addRightViewButton(image: UIImage, target: Any?, action: Selector) {
//            let button = UIButton(type: .custom)
//            button.setImage(image, for: .normal)
//            button.addTarget(target, action: action, for: .touchUpInside)
//            
//            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
//            button.frame = rightView.bounds
//            rightView.addSubview(button)
//            
//            self.rightView = rightView
//            self.rightViewMode = .always
//        }
    
    func setRightEyeBtn(showHideButtonTapped: Selector){
        let showHideButton = UIButton(type: .custom)
        showHideButton.setImage(UIImage(named: ImageConstants.eyeOffIcon), for: .normal)
        showHideButton.setImage(UIImage(named: ImageConstants.eyeOpenIcon), for: .selected)
        showHideButton.addTarget(self, action: showHideButtonTapped, for: .touchUpInside)
        showHideButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.rightView = showHideButton
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

