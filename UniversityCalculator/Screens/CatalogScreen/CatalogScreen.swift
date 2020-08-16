//
//  CatalogScreen.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct CatalogScreen: View {
    @ObservedObject var viewModel: CatalogScreenViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(" ").padding(.bottom)
            VStack {
                if(viewModel.calculatorStep == 0) {
                    InstitutionListView(viewModel: viewModel)
                        .opacity(viewModel.opacityForTables)
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 10.0)) {
                                self.viewModel.opacityForTables = 100.0
                            }
                    }
                } else if(viewModel.calculatorStep == 1) {
                    RecrutationListView(viewModel: viewModel)
                        .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                } else if(viewModel.calculatorStep == 2) {
                    CourseListView(viewModel: viewModel)
                    .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                } else if(viewModel.calculatorStep == 3) {
                    SubjectListView(viewModel: viewModel)
                    .opacity(viewModel.opacityForTables)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForTables = 100.0
                        }
                    }
                }
            }
            
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
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 10.0)) {
                            self.viewModel.opacityForButton = 100.0
                        }
                    }
                }
            }
            .padding(viewModel.calculatorStep == 3 ? .top : .vertical)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color(UIColor.blue))
            }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(UIColor.blue))
        .navigationBarTitle(viewModel.prepareTitle())
    }
}

struct CatalogScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatalogScreen(viewModel: CatalogScreenViewModel())
    }
}

struct InstitutionListView: View {
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List([exampleInstitution], id: \.self) { institution in
            Button(action: {
                self.viewModel.selectedInstitution = institution
            }, label: {
                VStack {
                    Text(institution.name)
                }
            })
        }
    }
}

struct RecrutationListView: View {
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List(viewModel.selectedInstitution!.recrutations, id: \.self) { recrutation in
            Button(action: {
                self.viewModel.selectedRecrutation = recrutation
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
                self.viewModel.selectedCourse = course
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

struct SubjectListView: View {
    @State var viewModel: CatalogScreenViewModel
    
    var body: some View {
        List(viewModel.selectedCourse!.subjects, id: \.self) { subject in
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


