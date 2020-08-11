//
//  Course.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

enum ModeType: String {
    case FullTime = "Full-Time"
    case PartTime = "Part-Time"
}

struct Course {
    let code: String?
    let name: String
    let level: Int
    let department: String
    let mode: ModeType
    let length: Int
    let description: String?
    let subjects: [Subject]
}
