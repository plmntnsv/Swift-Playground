//
//  NumberRule.swift
//  MilenaBooksApp
//
//  Created by Plamen on 4.12.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import SwiftValidator

class BookValidationRules {
    class NumberValidation: RegexRule {
        static let regex = "[^0-9]"
        
        convenience init(message : String = "Not a valid number"){
            self.init(regex: NumberValidation.regex, message : message)
        }
    }
    
    class OnlyEmptySpacesValidation: RegexRule {
        static let regex = "^[ \t\r\n]*$"
        
        convenience init(message : String = "Can not have only white spaces"){
            self.init(regex: OnlyEmptySpacesValidation.regex, message : message)
        }
    }
    
    class StartAndEndEmptySpacesValidation: RegexRule {
        static let regex = "(^[ \t\r\n]+)|([ \t\r\n]+\\z)"
        
        convenience init(message : String = "Can not have only white spaces"){
            self.init(regex: StartAndEndEmptySpacesValidation.regex, message : message)
        }
    }
}
