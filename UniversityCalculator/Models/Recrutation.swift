//
//  Recrutation.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

struct Recrutation: Hashable {
    static func == (lhs: Recrutation, rhs: Recrutation) -> Bool {
        lhs.id == rhs.id
    }
    let id: Int
    let yearFrom: String
    let yearTo: String
    var courses: [Course]
    var additionalInformations: String?
}

let exampleRecrutation = Recrutation(id: 0, yearFrom: "2020", yearTo: "2021", courses: [exampleCourse], additionalInformations: "Additional informations here.")
