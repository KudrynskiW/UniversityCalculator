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

struct Course: Hashable {
    static func == (lhs: Course, rhs: Course) -> Bool {
        lhs.code == rhs.code
    }
    
    let code: String
    let name: String
    let level: Int
    let department: String
    let mode: ModeType
    let length: Int
    let description: String?
    let subjects: [Subject]
}

let exampleCourse = Course(code: "EI-NI", name: "Information Technology", level: 1, department: "Department of Electrotechnics, Automatics and Information Technology", mode: .PartTime, length: 8, description: "Information technology for everyone who is passionate in IT!", subjects: [exampleSubject, exampleSubject2, exampleSubject3])
