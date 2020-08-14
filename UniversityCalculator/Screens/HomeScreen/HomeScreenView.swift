//
//  HomeScreenView.swift
//  UniversityCalculator
//
//  Created by Wojciech Kudrynski on 11/08/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import SwiftUI

struct HomeScreenView: View {
    @State var userName = "Guest"
    @State var screenStep = 1
    
    init() {
        let customAppearance = UINavigationBarAppearance()
        customAppearance.configureWithOpaqueBackground()
        customAppearance.backgroundColor = .blue
        customAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
               
        UINavigationBar.appearance().standardAppearance = customAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customAppearance
    }
    
    var body: some View {
        NavigationView {
            if(screenStep == 0) {
                NameView(screenStep: $screenStep, userName: $userName)
            } else if(screenStep == 1) {
                SubjectsView(userName: $userName)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct NameView: View {
    @Binding var screenStep: Int
    @Binding var userName: String
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello \(userName)!")
                .font(.title)
            Text("please, introduce yourself!")
            
            TextField("Enter your name", text: $userName)
                .padding(10)
                .frame(width: UIScreen.main.bounds.width/1.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).foregroundColor(.blue)
            )
            
            Button(action: {
                self.screenStep = 1
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.largeTitle)
            }.padding()
            
            Spacer()
            Spacer()
        }
        .navigationBarTitle("Home", displayMode: .inline)
    }
}

struct SubjectsView: View {
    @Binding var userName: String
    

    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Its nice to meet you \(userName)!")
                .font(.title)
            Text("do you want to fill your Subjects scores?")
            Text("(Click on the subject title)")
                .font(.footnote)
            ScrollView {
                ForEach(DefinedSubjects.allCases, id: \.self) { subject in
                    SubjectScoreView(subjectName: subject.rawValue)
                }
            }
            
            Spacer()
        }.navigationBarTitle("Home", displayMode: .inline)
    }
}

struct SubjectScoreView: View {
    @State var subjectName: String
    @State var baseScore: Int = 30
    @State var extendedScore: Int = 30
    
    @State var detailsHidden: Bool = true
    @State var baseScoreEnabled: Bool = false
    @State var extendedScoreEnabled: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                self.detailsHidden.toggle()
            }) {
                Text(subjectName)
                    .bold()
            }
            
            if(!detailsHidden) {
                HStack {
                    Button(action: {
                        self.baseScoreEnabled.toggle()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(baseScoreEnabled ? .green : .gray)
                    }
                    
                    Stepper("Base score: \(baseScore)", value: $baseScore, in: 30...100)
                        .disabled(!baseScoreEnabled)
                    
                }
                
                HStack {
                    Button(action: {
                        self.extendedScoreEnabled.toggle()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(extendedScoreEnabled ? .green : .gray)
                    }
                    
                    
                    Stepper("Extended score: \(extendedScore)", value: $extendedScore, in: 30...100)
                        .disabled(!extendedScoreEnabled)
                }
            }
        }.padding(10)
    }
}
