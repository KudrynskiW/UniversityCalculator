//
//  ExamResult.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

struct ExamResult: Hashable {
    var name: DefinedSubjects
    var baseResult: Int
    var extendedResult: Int
}

let examResult1 = ExamResult(name: .Mathematics, baseResult: 71, extendedResult: 41)
let examResult2 = ExamResult(name: .InformationTechnology, baseResult: 51, extendedResult: 0)

let examResults = [examResult1, examResult2]
