//
//  String+Extensions.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2020-06-22.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

extension String {
    
    /** Localize the string.*/
    func localize() -> String? {
        return NSLocalizedString(self, comment: "")
    }
}
