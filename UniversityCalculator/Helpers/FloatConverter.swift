//
//  FloatConverter.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 12/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

class FloatConverter {
    static func round(to digits: Int, for number: Float) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = digits
        nf.maximumFractionDigits = digits
        return nf.string(from: NSNumber(value: number))!
    }
    
}
