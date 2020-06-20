//
//  UIView+Extensions.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2020-06-19.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

extension UIView {
    
    /** Apply shadow around the view. */
    func applyShadow() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
}
