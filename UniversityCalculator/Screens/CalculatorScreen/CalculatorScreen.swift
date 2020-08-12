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
    @State var firstTitle = "Institution: "
    @State var secondTitle = "Recrutation: "
    @State var thirdTitle = "Course: "
    
    @State var selectedInstitution: Institution? = nil
    @State var selectedRecrutation: Recrutation? = nil
    @State var selectedCourse: Course? = nil
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                if(calculatorStep == 0) {
                    Text("Select \(firstTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    InstitutionListView(firstTitle: $firstTitle, selectedInstitution: $selectedInstitution, calculatorStep: $calculatorStep)
                } else if(calculatorStep == 1) {
                    Text("Select \(secondTitle)")
                        .font(.title)
                        .padding(.horizontal)
                    RecrutationListView(selectedInstitution: $selectedInstitution, selectedRecrutation: $selectedRecrutation, secondTitle: $secondTitle, calculatorStep: $calculatorStep)
                } else if(calculatorStep == 2) {
                    Text("Select \(thirdTitle)")
                        .font(.title)
                        .padding(.horizontal)
                    CourseListView(selectedRecrutation: $selectedRecrutation, selectedCourse: $selectedCourse, thirdTitle: $thirdTitle, calculatorStep: $calculatorStep)
                }
            }.cornerRadius(50.0)
            
            
            VStack {
                Text(selectedInstitution == nil ? firstTitle : firstTitle + " " + selectedInstitution!.name)
                    .font(.body)
                    .bold()
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
                
                Text(calculatorStep < 1 ? "" : selectedRecrutation == nil ? secondTitle : secondTitle + " " + selectedRecrutation!.yearFrom + "/" + selectedRecrutation!.yearTo)
                    .font(.body)
                    .bold()
                    .padding([.horizontal])
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
                
                Text(calculatorStep < 2 ? "" : selectedCourse == nil ? thirdTitle : "\(thirdTitle) (\(selectedCourse!.mode.rawValue)) \(selectedCourse!.name)")
                    .font(.body)
                    .bold()
                    .padding([.horizontal])
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
            }
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.blue)
            
            if(calculatorStep == 3) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Calculate")
                    }
                    
                    Spacer()
                }.padding(.vertical)
            }
        }.edgesIgnoringSafeArea(.bottom)
        .background(Color.blue)
    }
}

struct CalculatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorScreen()
    }
}

struct InstitutionListView: View {
    @Binding var firstTitle: String
    @Binding var selectedInstitution: Institution?
    @Binding var calculatorStep: Int
    
    var body: some View {
        List([exampleInstitution], id: \.self) { institution in
            Button(action: {
                self.selectedInstitution = institution
                self.calculatorStep = 1
            }, label: {
                Text(institution.name)
            })
        }
    }
}

struct RecrutationListView: View {
    @Binding var selectedInstitution: Institution?
    @Binding var selectedRecrutation: Recrutation?
    @Binding var secondTitle: String
    @Binding var calculatorStep: Int
    
    var body: some View {
        List(selectedInstitution!.recrutations, id: \.self) { recrutation in
            Button(action: {
                self.selectedRecrutation = recrutation
                self.calculatorStep = 2
            }, label: {
                VStack(alignment: .leading) {
                    Text("\(recrutation.yearFrom)/\(recrutation.yearTo)")
                        .font(.headline)
                    Text(recrutation.additionalInformations ?? "")
                }
            })
        }
    }
}

struct CourseListView: View {
    @Binding var selectedRecrutation: Recrutation?
    @Binding var selectedCourse: Course?
    @Binding var thirdTitle: String
    @Binding var calculatorStep: Int
    
    var body: some View {
        List(selectedRecrutation!.courses, id: \.self) { course in
            Button(action: {
                self.selectedCourse = course
                self.calculatorStep = 3
            }, label: {
                VStack(alignment: .leading) {
                    Text("(\(course.mode.rawValue)) \(course.name)")
                        .bold()
                        .font(.headline)
                    
                    Text(course.department)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("Code: (\(course.code))")
                        Spacer()
                        Text("Length: \(course.length)")
                        Spacer()
                        Text("Level: \(course.level)")
                    }.padding(.top)
                }
            })
        }
    }
}
