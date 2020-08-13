//
//  CatalogScreen.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct CatalogScreen: View {
    @ObservedObject var viewModel = CatalogScreenViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                if(viewModel.calculatorStep == 0) {
                    Text("Select \(viewModel.firstTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    InstitutionListView(viewModel: viewModel)
                        .opacity(viewModel.opacityForTables)
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 10.0)) {
                                self.viewModel.opacityForTables = 100.0
                            }
                    }
                } else if(viewModel.calculatorStep == 1) {
                    Text("Select \(viewModel.secondTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                        .animation(Animation.easeInOut(duration: 10))
                    RecrutationListView(viewModel: viewModel)
                        .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                } else if(viewModel.calculatorStep == 2) {
                    Text("Select \(viewModel.thirdTitle)")
                        .font(.title)
                        .padding([.horizontal, .top])
                    CourseListView(viewModel: viewModel)
                    .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                } else if(viewModel.calculatorStep == 3) {
                    Text("Subjects")
                        .font(.title)
                        .padding([.horizontal, .top])
                    
                    List(viewModel.selectedCourse!.subjects, id: \.self) { subject in
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
                    .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                }
            }.cornerRadius(50.0)
            
            
            VStack {
                BottomText(text: Text(viewModel.selectedInstitution == nil ? " " : viewModel.firstTitle + " " + viewModel.selectedInstitution!.name))
                
                BottomText(text: Text(viewModel.calculatorStep < 1 ? " " : viewModel.selectedRecrutation == nil ? " " : viewModel.secondTitle + " " + viewModel.selectedRecrutation!.yearFrom + "/" + viewModel.selectedRecrutation!.yearTo))
                
                BottomText(text: Text(viewModel.calculatorStep < 2 ? " " : viewModel.selectedCourse == nil ? " " : "\(viewModel.thirdTitle) (\(viewModel.selectedCourse!.mode.rawValue)) \(viewModel.selectedCourse!.name)"))
                
                if(viewModel.calculatorStep == 3) {
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
                    .opacity(viewModel.opacityForButton)
                }

            }
            .padding(viewModel.calculatorStep == 3 ? .top : .vertical)
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
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List([exampleInstitution], id: \.self) { institution in
            Button(action: {
                self.viewModel.opacityForTables = 0.0
                self.viewModel.selectedInstitution = institution
                self.viewModel.calculatorStep = 1
            }, label: {
                Text(institution.name)
            })
        }
    }
}

struct RecrutationListView: View {
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List(viewModel.selectedInstitution!.recrutations, id: \.self) { recrutation in
            Button(action: {
                self.viewModel.opacityForTables = 0.0
                self.viewModel.selectedRecrutation = recrutation
                self.viewModel.calculatorStep = 2
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
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List(viewModel.selectedRecrutation!.courses, id: \.self) { course in
            Button(action: {
                self.viewModel.opacityForTables = 0.0
                self.viewModel.selectedCourse = course
                self.viewModel.calculatorStep = 3
                withAnimation(Animation.easeIn(duration: 10).delay(0.3)) {
                    self.viewModel.opacityForButton = 100.0
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
