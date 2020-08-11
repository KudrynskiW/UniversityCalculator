//
//  CalculatorScreen.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct CalculatorScreen: View {
    @State var calculatorStep = 0
    @State var firstTitle = "Select Institution:"
    @State var secondTitle = "Select Recrutation:"
    @State var thirdTitle = "Select Course:"
    
    @State var selectedInstitution: Institution? = nil
    @State var selectedRecrutation: Recrutation? = nil
    @State var selectedCourse: Course? = nil
    var body: some View {
        VStack {
            Text(firstTitle)
                .font(selectedInstitution == nil ? .largeTitle : .title)
                .bold()
                .padding(selectedInstitution == nil ? .horizontal : .all)
                .multilineTextAlignment(.center)
            
            Text(calculatorStep < 1 ? "" : secondTitle)
                .font(.body)
                .bold()
                .padding([.horizontal])
            
            Text(calculatorStep < 2 ? "" : thirdTitle)
                .font(.body)
                .bold()
                .padding([.horizontal])
                
            if(calculatorStep == 0) {
                List([exampleInstitution], id: \.self) { institution in
                    Button(action: {
                        withAnimation {
                            self.firstTitle = institution.name
                            self.selectedInstitution = institution
                            self.calculatorStep = 1
                        }
                    }, label: {
                        Text(institution.name)
                    })
                }
            } else if(calculatorStep == 1) {
                List(selectedInstitution!.recrutations, id: \.self) { recrutation in
                    Button(action: {
                        withAnimation {
                            self.selectedRecrutation = recrutation
                            self.secondTitle = "Recrutation \(recrutation.yearFrom) - \(recrutation.yearTo)"
                            self.calculatorStep = 2
                        }
                    }, label: {
                        VStack(alignment: .leading) {
                            Text("\(recrutation.yearFrom) - \(recrutation.yearTo)")
                                .font(.headline)
                            Text(recrutation.additionalInformations ?? "")
                        }
                    })
                }
            } else if(calculatorStep == 2) {
                List(selectedRecrutation!.courses, id: \.self) { course in
                    Button(action: {
                        withAnimation {
                            self.thirdTitle = course.name
                            self.calculatorStep = 3
                        }
                    }, label: {
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text("(\(course.code)) \(course.name)")
                                    .bold()
                                    .font(.headline)
                            }
                            Text(course.description ?? "No descr")
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Text("Mode: \(course.mode.rawValue)")
                                Spacer()
                                Text("Length: \(course.length)")
                                Spacer()
                                Text("Level: \(course.level)")
                            }.padding(.top)
                            
//                            HStack {
//                                Text(course.department)
//                                    .font(.subheadline)
//                                    .multilineTextAlignment(.trailing)
//                            }
                            
                        }
                    })
                }
            }
            
        }
    }
}

struct CalculatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorScreen()
    }
}


