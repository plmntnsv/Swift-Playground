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
    class NumberRule: RegexRule {
        static let regex = "^[0-9]+$"
        
        convenience init(message : String = "Not a valid number."){
            self.init(regex: NumberRule.regex, message : message)
        }
    }
    
    class EmptySpacesRule: RegexRule {
        static let regex = "^(?! )[A-Za-z0-9 ]*(?<! )$"
        
        convenience init(message : String = "Field cannot have only white spaces and/or leading or trailing white spaces."){
            self.init(regex: EmptySpacesRule.regex, message : message)
        }
    }
}
