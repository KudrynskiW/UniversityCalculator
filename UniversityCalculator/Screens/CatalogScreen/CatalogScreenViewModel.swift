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
    
    @Published var selectedInstitution: Institution? = nil
    @Published var selectedRecrutation: Recrutation? = nil
    @Published var selectedCourse: Course? = nil
    
    @Published var opacityForTables = 0.0
    @Published var opacityForButton = 0.0
}
