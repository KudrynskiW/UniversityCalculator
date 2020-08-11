//
//  Institution.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

enum InstitutionType: String {
    case University = "University"
    case UniversityOfTechnology = "University of Technology"
}

struct Institution {
    let name: String
    let description: String?
    let type: InstitutionType
    let website: String?
    var recrutations: [Recrutation]
}
