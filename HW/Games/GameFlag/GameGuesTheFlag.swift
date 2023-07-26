//
//  GameGuesTheFlag.swift
//  WeSplit
//
//  Created by Artem Vekshin on 18.07.2023.
//

import SwiftUI



struct CapitalBlueString: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            
    }
}



struct FlagImage: View {
    var imageFlag: String
    var body: some View {
        Image(imageFlag)
            .renderingMode(.original)
            .cornerRadius(20)
            .shadow(radius: 10)
            .imageScale(.large)
    }
}

struct GameGuesTheFlag: View {
    @State private var showingAlert = false
    @State private var titleScore = ""
    @State private var urScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var chooseCorrect = true
    @State  var animationAmount = 1.0
    @State private var correctAns = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .purple, location: 0.3),
                .init(color: .cyan, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            
            VStack(spacing: 20){
                
                Text("Choose a correct flag")
                Text(countries[correctAns])
                    .font(.largeTitle.weight(.semibold))
                Spacer()
                ForEach(0..<3){ number in
                    withAnimation
                    {Button{
                        flagWasTapped(number)
                        
                        
                        
                    } label: {
                        FlagImage(imageFlag: countries[number])
                            
                            .rotation3DEffect(.degrees(chooseCorrect ? 0 : (correctAns == number ? 360 : 0)), axis: (x: 1, y: 0, z: 0))
                            .animation(.easeIn(duration: 1.0))
                        
                    }
                   
                        
                    }}
                Spacer()
                Text("Score:\(urScore)")
                    .font(.largeTitle.bold())
                Spacer()
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }.alert(titleScore, isPresented: $showingAlert) {
            Button("Continue", action: Reload )
        } message: {
            Text("Your score is \(urScore)")
        }
    }
    //space for functions
    
    
    func Reload() {
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
        chooseCorrect = true

    }
    func flagWasTapped(_ number:Int){
        if number == correctAns{
            titleScore = "Correct"
            urScore += 1
            chooseCorrect.toggle()
        }else{
            titleScore = "Not correct, Loser"
        }
        
        showingAlert = true
        
        
    }


}



#Preview {
    GameGuesTheFlag()
}
