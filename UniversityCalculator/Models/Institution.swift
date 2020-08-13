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

struct Institution: Hashable {
    static func == (lhs: Institution, rhs: Institution) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    let description: String?
    let type: InstitutionType
    let website: URL?
    var recrutations: [Recrutation]
}

let exampleInstitution = Institution(name: "Poznan University of Technology", description: "This is a description", type: .UniversityOfTechnology, website: URL(string: "https://po.edu.pl"), recrutations: [exampleRecrutation])
