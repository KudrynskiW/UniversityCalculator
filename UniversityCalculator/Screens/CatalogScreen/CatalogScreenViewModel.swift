//
//  CatalogScreenViewModel.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import SwiftUI

class CatalogScreenViewModel: ObservableObject {
    @Published var calculatorStep = 0
    @Published var firstTitle = "Institution: "
    @Published var secondTitle = "Recrutation: "
    @Published var thirdTitle = "Course: "
    
    @Published var selectedInstitution: Institution? = nil {
        didSet {
            calculatorStep = 1
            opacityForTables = 0.0
        }
    }
    @Published var selectedRecrutation: Recrutation? = nil {
        didSet {
            calculatorStep = 2
            opacityForTables = 0.0
        }
    }
    @Published var selectedCourse: Course? = nil {
        didSet {
            calculatorStep = 3
            opacityForTables = 0.0
        }
    }
    
    @Published var opacityForTables = 0.0
    @Published var opacityForButton = 0.0
    
    func prepareTitle() -> String {
        switch calculatorStep {
        case 1:
            return "Select \(secondTitle)"
        case 2:
            return "Select \(thirdTitle)"
        case 3:
            return "Subjects:"
        default:
            return "Select \(firstTitle)"
        }
    }
}
