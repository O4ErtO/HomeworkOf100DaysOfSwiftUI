//
//  CheckOutView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 13.09.2023.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var viewModel: Order
    
    @State private var messageAlert = ""
    @State private var showAlert = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){
                    image in
                    image
                        .resizable()
                        .scaledToFill()
                }placeholder: {
                    ProgressView()
                }.frame(height: 233)
                Text("Your total cost \(viewModel.cost, format: .currency(code: "USD"))")
                
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }.alert("Thank you",isPresented: $showAlert) {
            Button("OK"){}
            
        }message: {
            Text(messageAlert)
        }
          
    }
    func placeOrder() async{
        guard let encoded = try? JSONEncoder().encode(viewModel) else{
            print("Don't encoded message")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            messageAlert = "Your oder for \(decodedOrder.quntity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is done!"
            showAlert = true
        }catch{
            print("Don't encoded")
        }
    }
}

#Preview {
    CheckOutView(viewModel: Order())
}
