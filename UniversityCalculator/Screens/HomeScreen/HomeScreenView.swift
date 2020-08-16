//
//  HomeScreenView.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    init() {
        let customAppearance = UINavigationBarAppearance()
        customAppearance.configureWithOpaqueBackground()
        customAppearance.backgroundColor = UIColor.blue
        customAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = customAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customAppearance
        
        viewModel.screenStep = 2
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if(viewModel.screenStep == 0) {
                    NameView(viewModel: viewModel)
                } else if(viewModel.screenStep == 1) {
                    SubjectsView(viewModel: viewModel)
                } else if(viewModel.screenStep == 2) {
                    DefaultHomeView(viewModel: viewModel)
                }
                
                if(viewModel.screenStep < 2) {
                    BottomButtonsView(viewModel: viewModel)
                }
            }.frame(width: UIScreen.main.bounds.width)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct NameView: View {
    @State var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello Guest!")
                .font(.title)
            Text("please, introduce yourself!")
            
            TextField("Enter your name", text: $viewModel.userName)
                .padding(10)
                .frame(width: UIScreen.main.bounds.width/1.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).foregroundColor(.blue)
            )
            Spacer()
        }
        .navigationBarTitle("Initial Setup 1/2", displayMode: .inline)
    }
}

struct SubjectsView: View {
    @State var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Its nice to meet you \(viewModel.userName)!")
                .font(.title)
            Text("do you want to fill your Subjects scores?")
            Text("(Click on the subject title)")
                .font(.footnote)
            ScrollView {
                ForEach(DefinedSubjects.allCases, id: \.self) { subject in
                    SubjectScoreView(subjectName: subject.rawValue)
                }.frame(width: UIScreen.main.bounds.width)
            }
            
        }.navigationBarTitle("Initial Setup 2/2", displayMode: .inline)
    }
}

struct SubjectScoreView: View {
    @State var subjectName: String
    @State var baseScore: Float = 50
    @State var extendedScore: Float = 50
    
    @State var detailsHidden: Bool = true
    @State var baseScoreEnabled: Bool = false
    @State var extendedScoreEnabled: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                self.detailsHidden.toggle()
            }) {
                Text(subjectName)
                    .font(.headline)
                    .bold()
                    .fixedSize()
            }
            
            if(!detailsHidden) {
                VStack {
                HStack {
                    Button(action: {
                        self.baseScoreEnabled.toggle()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(baseScoreEnabled ? .green : .gray)
                    }
                    
                    Stepper("Base score: \(Int(baseScore))", value: $baseScore, in: 1...100)
                        .disabled(!baseScoreEnabled)
      
                }
                    
                    Slider(value: $baseScore, in: 1...100, step: 1.0)
                        .disabled(!baseScoreEnabled)
                
                HStack {
                    Button(action: {
                        self.extendedScoreEnabled.toggle()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(extendedScoreEnabled ? .green : .gray)
                    }
                    
                    
                    Stepper("Extended score: \(Int(extendedScore))", value: $extendedScore, in: 1...100)
                        .disabled(!extendedScoreEnabled)
                }
                    Slider(value: $extendedScore, in: 1...100, step: 1.0)
                        .disabled(!extendedScoreEnabled)
                }
            }
        }.padding(10)
    }
}

struct BottomButtonsView: View {
    @State var viewModel: HomeScreenViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.viewModel.screenStep = 2
            }) {
                Text("SKIP")
                    .frame(width: UIScreen.main.bounds.width/6)
                    .padding()
                    .font(.headline)
                    .background(Color.red)
                    .cornerRadius(20)
                    .accentColor(.white)
            }
            
            Spacer()
            
            Button(action: {
                self.viewModel.screenStep += 1
            }) {
                HStack {
                    Text("NEXT")
                        .fixedSize()
                    Image(systemName: "arrow.right.circle.fill")
                }.frame(width: UIScreen.main.bounds.width/2)
                    .padding()
                    .font(.headline)
                    .background(Color(UIColor.blue))
                    .cornerRadius(20)
                    .accentColor(.white)
            }
            
            Spacer()
        }
    }
}

struct DefaultHomeView: View {
    @State var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack {
            Text("Hello, \(viewModel.user.name ?? "Guest")!")
                .font(.title)
                .bold()
                .padding()
                .fixedSize()
            
            if(!viewModel.user.examsResults.isEmpty) {
                VStack(alignment: .leading) {
                    Text("Saved Subject scores:")
                        .font(.title)
                    
                    ForEach(viewModel.user.examsResults, id: \.self) { result in
                        VStack(alignment: .leading) {
                            Text(result.name.rawValue)
                                .bold()
                            HStack {
                                Text("Base: \(result.baseResult)%")
                                Spacer()
                                if(result.extendedResult != 0) {
                                    Text("Extended: \(result.extendedResult)%")
                                }
                                Spacer()
                                Spacer()
                            }
                            
                        }
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width/1.1, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(UIColor.blue), lineWidth: 2)
                )
            }
            
            if(!viewModel.user.savedCourses.isEmpty) {
                VStack(alignment: .leading) {
                    Text("Saved Courses:")
                        .font(.title)
                    
                    ForEach(viewModel.user.savedCourses, id: \.self) { course in
                        VStack(alignment: .leading) {
                            Text("(\(course.mode.rawValue)) \(course.name)")
                                .bold()
                                .font(.headline)
                            
                            Text("Score: xxx")
                        }
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width/1.1, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(UIColor.blue), lineWidth: 2)
                )
                    .padding()
            }
            

            Spacer()
            
            NavigationLink(destination: CatalogScreen(viewModel: CatalogScreenViewModel())) {
                Text("OPEN CATALOG")
                    .frame(width: UIScreen.main.bounds.width/1.5)
                    .padding()
                    .font(.headline)
                    .background(Color(UIColor.blue))
                    .cornerRadius(20)
                    .accentColor(.white)
            }
            
            Spacer()
        }.navigationBarTitle("Home", displayMode: .inline)
    }
}
