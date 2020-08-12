//
//  CatalogScreen.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct CatalogScreen: View {
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
                        .padding([.horizontal, .top])
                    RecrutationListView(selectedInstitution: $selectedInstitution, selectedRecrutation: $selectedRecrutation, secondTitle: $secondTitle, calculatorStep: $calculatorStep)
                } else if(calculatorStep == 2) {
                    Text("Select \(thirdTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    CourseListView(selectedRecrutation: $selectedRecrutation, selectedCourse: $selectedCourse, thirdTitle: $thirdTitle, calculatorStep: $calculatorStep)
                }
            }.cornerRadius(50.0)
            
            
            VStack {
                Text(selectedInstitution == nil ? " " : firstTitle + " " + selectedInstitution!.name)
                    .font(.body)
                    .bold()
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
                
                Text(calculatorStep < 1 ? " " : selectedRecrutation == nil ? " " : secondTitle + " " + selectedRecrutation!.yearFrom + "/" + selectedRecrutation!.yearTo)
                    .font(.body)
                    .bold()
                    .padding([.horizontal])
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
                
                Text(calculatorStep < 2 ? " " : selectedCourse == nil ? " " : "\(thirdTitle) (\(selectedCourse!.mode.rawValue)) \(selectedCourse!.name)")
                    .font(.body)
                    .bold()
                    .padding([.horizontal])
                    .animation(Animation.linear(duration: 0.5))
                    .fixedSize()
            }
            .padding(calculatorStep == 3 ? .top : .vertical)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.blue)
            
            if(calculatorStep == 3) {
                VStack {
                    List(selectedCourse!.subjects, id: \.self) { subject in
                        Button(action: {
                            
                            
                        }, label: {
                            VStack(alignment: .leading) {
                                Text(subject.name.rawValue)
                                .font(.body)
                                .bold()
                                
                                HStack {
                                    Text("Base factor: \(FloatConverter.round(to: 1, for: subject.baseFactor))")
                                    Spacer()
                                    Text("Extended factor: \(FloatConverter.round(to: 1, for: subject.extendedFactor))")
                                    Spacer()
                                }
                            }
                            
                        })
                    }
                }
                
                VStack {
                    Text("Selected Subjects: 1 of 3")
                        .font(.body)
                        .bold()
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .animation(Animation.linear(duration: 0.5))
                        .fixedSize()
                    
                    Text("Calculate with saved Scores")
                        .font(.body)
                        .bold()
                        .padding([.horizontal])
                        .animation(Animation.linear(duration: 0.5))
                        .fixedSize()
                    
                    Text("Calculate with new Scores")
                        .font(.body)
                        .bold()
                        .padding([.horizontal])
                        .animation(Animation.linear(duration: 0.5))
                        .fixedSize()
                }
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.blue)
            }
        }.edgesIgnoringSafeArea(.bottom)
        .background(Color.blue)
    }
}

struct CatalogScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatalogScreen()
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
                        Text("Semesters: \(course.length)")
                        Spacer()
                        Text("Level: \(course.level)")
                    }.padding(.top)
                }
            })
        }
    }
}
