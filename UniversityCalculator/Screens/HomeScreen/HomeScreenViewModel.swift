//
//  HomeScreenViewModel.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published var user: User = exampleUser
    @Published var userName = ""
    @Published var screenStep = 0
}
