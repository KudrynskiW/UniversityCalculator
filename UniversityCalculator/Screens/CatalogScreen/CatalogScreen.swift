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
    
    @State var opacityForTables = 0.0
    @State var opacityForButton = 0.0
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                if(calculatorStep == 0) {
                    Text("Select \(firstTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    InstitutionListView(firstTitle: $firstTitle, selectedInstitution: $selectedInstitution, calculatorStep: $calculatorStep, opacityForTables: $opacityForTables)
                        .opacity(opacityForTables)
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 10.0)) {
                                self.opacityForTables = 100.0
                            }
                    }
                } else if(calculatorStep == 1) {
                    Text("Select \(secondTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                        .animation(Animation.easeInOut(duration: 10))
                    RecrutationListView(selectedInstitution: $selectedInstitution, selectedRecrutation: $selectedRecrutation, secondTitle: $secondTitle, calculatorStep: $calculatorStep, opacityForTables: $opacityForTables)
                    .opacity(opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.opacityForTables = 100.0
                        }
                    }
                } else if(calculatorStep == 2) {
                    Text("Select \(thirdTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    CourseListView(selectedRecrutation: $selectedRecrutation, selectedCourse: $selectedCourse, thirdTitle: $thirdTitle, calculatorStep: $calculatorStep, opacityForButton: $opacityForButton, opacityForTables: $opacityForTables)
                    .opacity(opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.opacityForTables = 100.0
                        }
                    }
                } else if(calculatorStep == 3) {
                    Text("Subjects")
                        .font(.title)
                        .padding([.horizontal, .top])
                    
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
                    .opacity(opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.opacityForTables = 100.0
                        }
                    }
                }
            }.cornerRadius(50.0)
            
            
            VStack {
                BottomText(text: Text(selectedInstitution == nil ? " " : firstTitle + " " + selectedInstitution!.name))
                
                BottomText(text: Text(calculatorStep < 1 ? " " : selectedRecrutation == nil ? " " : secondTitle + " " + selectedRecrutation!.yearFrom + "/" + selectedRecrutation!.yearTo))
                
                BottomText(text: Text(calculatorStep < 2 ? " " : selectedCourse == nil ? " " : "\(thirdTitle) (\(selectedCourse!.mode.rawValue)) \(selectedCourse!.name)"))
                
                if(calculatorStep == 3) {
                    Button(action: {
                        
                    }) {
                        Text("CALCULATE SCORE")
                            .padding()
                            .font(.headline)
                            .background(Color.white)
                            .cornerRadius(20)
                            .accentColor(.blue)
                    }
                    .padding()
                    .opacity(opacityForButton)
                }
                
                
                
            }
            .padding(calculatorStep == 3 ? .top : .vertical)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.blue)
            
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
    @Binding var opacityForTables: Double
    
    var body: some View {
        List([exampleInstitution], id: \.self) { institution in
            Button(action: {
                self.opacityForTables = 0.0
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
    @Binding var opacityForTables: Double
    
    var body: some View {
        List(selectedInstitution!.recrutations, id: \.self) { recrutation in
            Button(action: {
                self.opacityForTables = 0.0
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
    @Binding var opacityForButton: Double
    @Binding var opacityForTables: Double
    
    var body: some View {
        List(selectedRecrutation!.courses, id: \.self) { course in
            Button(action: {
                self.opacityForTables = 0.0
                self.selectedCourse = course
                self.calculatorStep = 3
                withAnimation(Animation.easeIn(duration: 10).delay(0.3)) {
                    self.opacityForButton = 100.0
                }
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

struct BottomText: View {
    var text: Text
    
    var body: some View {
        text
            .foregroundColor(.white)
            .font(.body)
            .bold()
            .padding(.horizontal)
            .multilineTextAlignment(.leading)
            .animation(Animation.linear(duration: 0.5))
            .fixedSize()
    }
}
