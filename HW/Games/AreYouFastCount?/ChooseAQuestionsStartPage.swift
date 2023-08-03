//
//  ChooseAQuestionsStartPage.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 03.08.2023.
//

import SwiftUI

struct KKK: View {
    @State private var numberOfQuestions = 5
    @State private var showGame = false
    
    var body: some View {
        VStack {
            if !showGame {
                QuestionSelectionView(numberOfQuestions: $numberOfQuestions, showGame: $showGame)
            } else {
                GameCalculator(numberOfQuestions: numberOfQuestions)
            }
        }
    }
}

struct QuestionSelectionView: View {
    @Binding var numberOfQuestions: Int
    @Binding var showGame: Bool
    
    var body: some View {
        VStack {
            Text("Выберите количество вопросов:")
                .font(.headline)
            
            Picker("Количество вопросов", selection: $numberOfQuestions) {
                Text("5").tag(5)
                Text("10").tag(10)
                Text("15").tag(15)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                showGame = true
            }) {
                Text("Играть")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}



