//
//  Subject.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

struct Subject: Hashable {
    let name: DefinedSubjects
    let baseFactor: Float
    let extendedFactor: Float
}

let exampleSubject = Subject(name: .Mathematics, baseFactor: 2.0, extendedFactor: 2.0)
let exampleSubject2 = Subject(name: .InformationTechnology, baseFactor: 2.0, extendedFactor: 2.0)
let exampleSubject3 = Subject(name: .ForeignLanguage, baseFactor: 0.5, extendedFactor: 0.5)
