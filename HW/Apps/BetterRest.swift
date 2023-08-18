//
//  BetterRest.swift
//  WeSplit
//
//  Created by Artem Vekshin on 21.07.2023.
//
import CoreML
import SwiftUI

struct BetterRest: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
       
        NavigationView{
            Form{
                VStack{
                    Text("When do you need get up?")
                        .font(.headline)
                    DatePicker("Pick time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack{
                    Text("How muach do you need sleep?")
                    
                    Stepper("\(sleepAmount.formatted())hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack{
                    Text("How much cup of coffe you drink?")
                    
                    Stepper(coffeAmount == 1 ? "1 cup" : "\(coffeAmount) cups" , value: $coffeAmount, in: 1...20)
                }
            }.padding()
                .toolbar {
                    Button("Calculate", action: calculateBedtime)
                }.alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
        }
    }
    func calculateBedtime() {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculate(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}
struct BetterRest_Previews: PreviewProvider {
    static var previews: some View {
        BetterRest()
    }
}
