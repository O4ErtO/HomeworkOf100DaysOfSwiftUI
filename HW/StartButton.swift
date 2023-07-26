//
//  StartButton.swift
//  WeSplit
//
//  Created by Artem Vekshin on 25.07.2023.
//

import SwiftUI


struct StartButton: View {
    @State private var animationAmount = 1.0
    @State private var showNextView = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                Button("Start") {
                    showNextView = true
                }
                .padding(50)
                .frame(width: 300, height: 100)
                .background(.red)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                                    .easeInOut(duration: 1)
                                        .repeatForever(autoreverses: false),
                                    value: animationAmount
                                )
                )
                .onAppear {
                    animationAmount = 2
                }
                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $showNextView) {
                    EmptyView()
                }
            }
            }
        
    }
}




struct MainView1: View {
    var body: some View {
        Text("Next View")
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



#Preview {
    StartButton()
}
