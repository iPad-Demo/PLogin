//
//  PTextField.swift
//  PLogin
//
//  Created by os on 2019/9/2.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit

class PTextField: UITextField {

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
       var iconRect = super.leftViewRect(forBounds: bounds)
       iconRect.origin.x += 10
       return iconRect
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var placeholderRect = super.placeholderRect(forBounds: bounds)
        placeholderRect.origin.x += 1
        return placeholderRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var editingRect = super.editingRect(forBounds: bounds)
        editingRect.origin.x += 20
        return editingRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += 20
        return textRect
    }
}
