//
//  RockPaperView.swift
//  WeSplit
//
//  Created by dsm 5e on 21.07.2023.
//

import SwiftUI

enum GameChoice: String, CaseIterable {
    case rock = "🤜"
    case paper = "✋"
    case scissors = "✌️"
}

enum GameState: String, CaseIterable {
    case win = "Победа 🥰"
    case fall = "Поражение 😏"
    case tie = "Ничья 🥺"
}

struct RockPaperView: View {
    @State private var isCardVisible = false
    @State private var showingResultAlert = false
    @State private var playerWeapon: GameChoice?
    @State private var aiWeapon: GameChoice?
    @State private var gameState: GameState?
    @State private var playerScore = 0
    @State private var aiScore = 0
    @State private var counter = 0

    let choices: [GameChoice] = [.rock, .paper, .scissors]

    var body: some View {
        ZStack {
           
            VStack {
                Text("Game RPS)")
                    .font(.title.bold())
                    .foregroundColor(Color.yellow)
                Text("Выбери свое оружие")
                    .foregroundColor(Color("RockButtonBackground"))
                    .font(.title2.bold())
                    .padding(.bottom, 20)

                HStack {
                    playerWeaponView

                    if playerWeapon == nil {
                        ForEach(choices, id: \.self) { choice in
                            Spacer()
                            Button {
                                playerWeapon = choice
                                withAnimation(.spring()) {
                                    isCardVisible = true
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 70, height: 70)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(choice == playerWeapon ? Color.green : .indigo)
                                    .overlay {
                                        Text(choice.rawValue)
                                            .font(.system(size: 40))
                                    }
                            }
                            Spacer()
                        }
                    }
                }
                .padding(10)
                

                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.1))
                    .overlay {
                        VStack {
                            Text("Комп выбрал:")
                                .foregroundColor(.cyan)
                                .font(.title.bold())
                                .padding(.top, 15)
                            Spacer()

                            Text("\(aiWeapon?.rawValue ?? "")")
                                .font(.system(size: 120))
                            Spacer()
                        }
                    }

                HStack {
                    VStack {
                        Text("Игрок")
                            .font(.caption)
                        Text("\(playerScore)")
                            .bold()
                    }
                    .foregroundColor(.blue)
                    Spacer()

                    Button {
                        resetGame()
                        playerScore = 0
                        aiScore = 0
                    } label: {
                        Text("Сбросить счет")
                            .font(.title2.bold())
                            .foregroundColor(aiScore < 1 ? Color.gray : .green)
                            .padding(10)
                    }
                    Spacer()
                    VStack {
                        Text("Комп")
                            .font(.caption)
                        Text("\(aiScore)")
                            .bold()
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray.opacity(0.1)))
            }
            .padding()
            .padding(.bottom, 10)
            .edgesIgnoringSafeArea(.bottom)

            if isCardVisible {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isCardVisible = false
                            playerWeapon = nil
                        }
                    }

                VStack {
                    Text("Выбираешь \(playerWeapon?.rawValue ?? "оружие")?")
                        .font(.title.bold())
                        .foregroundColor(.white)

                    HStack(spacing: 30) {
                        Button("Да") {
                            withAnimation(.spring()) {
                                isCardVisible = false
                            }
                            startGame()
                        }
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)

                        Button("Нет") {
                            withAnimation(.spring()) {
                                playerWeapon = nil
                                isCardVisible = false
                            }
                        }
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
                .padding(40)
            }
        }
        .alert(isPresented: $showingResultAlert) {
            switch gameState {
            case .win:
                return Alert(title: Text("Победа!"), message: Text("Поздравляю! Ты победил!"), dismissButton: .default(Text("OK"), action: { resetGame() }))
            case .fall:
                return Alert(title: Text("Поражение("), message: Text("Компьютер выиграл! Попробуй еще раз!"), dismissButton: .default(Text("OK"), action: { resetGame() }))
            case .tie:
                return Alert(title: Text("Ничья?!"), message: Text("Ничья! Не расстраивайся, попробуй еще!"), dismissButton: .default(Text("OK"), action: { resetGame() }))
            case .none:
                return Alert(title: Text(""), message: nil, dismissButton: .default(Text("OK"), action: { resetGame() }))
            }
        }
    }

    private var playerWeaponView: some View {
        if let playerWeapon = playerWeapon {
            return AnyView(
                Button {
                    withAnimation(.spring()) {
                        self.playerWeapon = nil
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70)
                        .foregroundColor(.mint)
                        .overlay {
                            Text(playerWeapon.rawValue)
                                .font(.system(size: 40))
                        }
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }

    private func startGame() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            aiWeapon = choices.randomElement()
            counter += 1
            if counter == 15 {
                timer.invalidate()
            }
        }
        counter = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let playerChoice = playerWeapon, let aiChoice = aiWeapon {
                if playerChoice == aiChoice {
                    gameState = .tie
                } else if (playerChoice == .rock && aiChoice == .scissors) ||
                            (playerChoice == .paper && aiChoice == .rock) ||
                            (playerChoice == .scissors && aiChoice == .paper) {
                    gameState = .win
                    playerScore += 1
                } else {
                    gameState = .fall
                    aiScore += 1
                }
                showingResultAlert = true
            }
        }
    }

    private func resetGame() {
        playerWeapon = nil
        aiWeapon = nil
        gameState = nil
    }
}

struct RockPaperView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperView()
    }
}
