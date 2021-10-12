//
//  ContentView.swift
//  pomodoro WatchKit Extension
//
//  Created by Joel de León on 11/10/21.
//

import SwiftUI

struct OptionsView: View {
    @Binding var optionsViewShown: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
    }
}

struct MainView: View {
    @State var optionsViewShown: Bool = false
    @State private var clicked: Bool = false
    @State private var counterActive: Bool = false
    @State private var type = 3 // 0 = pomo, 1 = short, 2 = long, 3 = stop
    @State private var timeRemaining = 25 * 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let formatter = DateComponentsFormatter()
    
    func options() {
        self.clicked = true
        print("Pressed!")
    }
    
    func startTimer() {
        self.counterActive = true
        self.type = 0
    }
    
    func pauseTimer() {
        self.counterActive = false
        self.type = 3
    }
    
    func cancelTimer() {
        self.counterActive = false
        self.type = 3
        self.timeRemaining = 25 * 60
    }
    
    func skipTimer() {
        if self.type == 0 {
            self.type = 1
            self.timeRemaining = 5 * 60
        }
    }
    
    func returnColorByType() -> Color {
        switch self.type {
        case 3:
            return Color.gray
        case 2:
            return Color.purple
        case 1:
            return Color.blue
        default:
            return Color.green
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 100) {
                VStack {
                    NavigationLink(destination: OptionsView(optionsViewShown: $optionsViewShown), isActive: $optionsViewShown, label: {Text("GO")})
                    .frame(width: 16, height: 16)
                    .clipShape(Circle())
                }.frame(width: 180, alignment: .trailing)
            }
            
            Text("\((self.timeRemaining % 3600) / 60)")
                .font(.system(size: 40))
                .foregroundColor(returnColorByType()).onReceive(timer) { time in
                    if self.timeRemaining > 0 && self.counterActive {
                        self.timeRemaining -= 1
                    } else if self.timeRemaining == 0 && self.counterActive {
                        skipTimer()
                        WKInterfaceDevice.current().play(.notification)
                        WKInterfaceDevice.current().play(.notification)
                        WKInterfaceDevice.current().play(.notification)
                    }
                }
            
            Divider()
            
            VStack {
                Button("Skip", action: skipTimer).frame(width: 80, height: 50)
                
                HStack {
                    Button(counterActive ? "Pause" : "Start", action: counterActive ? pauseTimer : startTimer)
                        .frame(width: 80, height: 50)
                    Button("Cancel", action: cancelTimer)
                        .frame(width: 80, height: 50)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
