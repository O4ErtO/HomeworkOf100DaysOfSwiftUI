//
//  MainView.swift
//  WeSplit
//
//  Created by Artem Vekshin on 18.07.2023.
//

import SwiftUI



struct MainView: View {

    var body: some View {
        NavigationStack{
            Form{
                NavigationLink{
                    ContentView()
                }label: {
                    Text("TipCounter")
                }
                NavigationLink{
                    VolumeCalculator()
                    
                } label: {
                    Text("Volume calculator")
                }
                
                NavigationLink{
                    GameGuesTheFlag()
                } label: {
                    Image(systemName: "gamecontroller")
                    Text("  🏳️‍🌈")
                }
                NavigationLink{
                    BetterRest()
                }label: {
                    Text("Your good sleep")
                }
                NavigationLink{
                    RockPaperView()
                }label: {
                    Image(systemName: "gamecontroller")
                    Text("Game rock")
                    
                }
                NavigationLink{
                    
                    WordScramble()
                }label: {
                Image(systemName: "gamecontroller")
                Text("Word Scramble")
                    
                }
                NavigationLink{
                    KKK()
                }label: {
                    Image(systemName: "gamecontroller")

                    Text("Game calculator")
                }
                
                NavigationLink{
                    ContentVieiw()
                }label: {
                    Text("iExpense")
                }
                NavigationLink{
                    MoonShotView()
                }label: {
                    Text("MoonShot")
                }
                NavigationLink{
                   ListHobbies()
                       
                }label: {
                    Text("Challenge 7-9")
                }
                
                NavigationLink{
                    CornerOrderMainView(order: Order())
                }label: {
                    Text("CupCakes order")
                }
                NavigationLink{
                    MainTenView()
                    
                }label:{
                    Text("RelationShip ")
                }
            }.navigationTitle("Homework")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
