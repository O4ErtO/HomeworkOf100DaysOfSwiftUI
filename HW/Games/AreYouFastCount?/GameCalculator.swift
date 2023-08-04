//
//  GameCalculator.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 26.07.2023.
//

import SwiftUI
struct GameCalculator: View {
    @State private var currentQuestion = 0
    let numberOfQuestions: Int
    @State private var multiplicationTable: Int = 2
    @State private var firstNumber: Int = 0
    @State private var secondNumber: Int = 0
    @State private var correctAnswer: Int = 0
    @State private var options: [Int] = []
    @State private var selectedOption = false
    @State private var score: Int = 0
    @State private var alertTitle = ""
    @State private var showingAlert = false
    @State private var wrongAnswer = false
    @State private var checkWrongAnswers = false
   
    var body: some View {
        VStack {
            if currentQuestion <= numberOfQuestions{
                Text("Вопрос \(currentQuestion)")
                Spacer()
                Text("Multiplication Game")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .padding()
                
                Text("\(firstNumber) x \(secondNumber) = \(checkWrongAnswers ? String(correctAnswer) : "?")")
                    .font(.largeTitle)
                    .frame(width: 200, height: 100)
                    .padding()
                
                Spacer()
                
                VStack {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 40),
                            GridItem(.flexible(), spacing: 40)
                        ],
                        spacing: 10
                    ) {
                        
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                checkAnswer(option)
                            }) {
                                Text("\(option)")
                                    .font(.title)
                                
                                    .frame(width: 190, height: 85)
                                
                                    .foregroundColor(.white)
                                    .background(selectedOption ? (correctAnswer == option ? .green : .gray) :  (checkWrongAnswers ? (option != correctAnswer ? .red : .green)  : .gray))
                                    .animation(.easeInOut(duration: 1))
                                    .clipShape(Rectangle())
                                    .cornerRadius(20)
                                
                                
                            }
                        }
                    }.padding()
                }.animation(.easeIn(duration: 1))
                Spacer()
                Button(action: {
                    generateQuestion()
                }) {
                    Text("Next Question")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                
                .padding()
            } else {
                Text("Игра окончена!")
                    .font(.title)
                    .padding()
                Text("Счет: \(score) / \(numberOfQuestions)")
                    .font(.headline)
                    .padding()
            }
            
            
        }.alert(alertTitle, isPresented: $showingAlert){
            Button("Next question ->", action: generateQuestion)
        } message:{
            Text("Nice! Go to the next question!")
        }
        .alert(alertTitle, isPresented: $wrongAnswer) {
            Button("Chek the correct answer") {
                checkWrongAnswers.toggle()
            }
        } message: {
            Text("No bad, u can will be better")
        }
        .onAppear {
            generateQuestion()
        }
    }
    
    func badAnswer(){
        
    }
    func generateQuestion() {
        firstNumber = Int.random(in: 1...9)
        secondNumber = Int.random(in: 1...12)
        correctAnswer = firstNumber * secondNumber
        options = generateAnswerOptions()
        selectedOption = false
        checkWrongAnswers = false
        currentQuestion += 1
    }
    
    func generateAnswerOptions() -> [Int] {
        var options = [correctAnswer]
        while options.count < 4 {
            let option = Int.random(in: 1...144)
            if !options.contains(option) {
                options.append(option)
            }
        }
        options.shuffle()
        return options
    }
    func nextQuestion() {
           currentQuestion += 1
       }
    func checkAnswer(_ option: Int) {
        if option == correctAnswer {
            score += 1
            selectedOption = true
            alertTitle = "Correct!"
            showingAlert = true
            
        }else{
            alertTitle = "Wrong"
            wrongAnswer = true
        }
   
    }
}


