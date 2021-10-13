//
//  ContentView.swift
//  pomodoro WatchKit Extension
//
//  Created by Joel de León on 11/10/21.
//

import SwiftUI

struct MainView: View {
    @State var optionsViewShown: Bool = false
    @State private var clicked: Bool = false
    @State private var isActive: Bool = false
    @State private var type = 3 // 0 = pomo, 1 = short, 2 = long, 3 = stop
    @State private var timeRemaining = 25 * 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let formatter = DateComponentsFormatter()
    let pomodoroTimer: TimerModel
    let shortBreakTimer: TimerModel
    let longBreakTimer: TimerModel
    
    func options() {
        self.clicked = true
        print("Pressed!")
    }
    
    func startTimer() {
        self.isActive = true
        self.type = 0
    }
    
    func pauseTimer() {
        self.isActive = false
        self.type = 3
    }
    
    func cancelTimer() {
        self.isActive = false
        self.type = 3
        self.timeRemaining = 25 * 60
    }
    
    func skipTimer() {
        if self.type == 0 {
            self.type = 1
            self.timeRemaining = 5 * 60
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 0) {
                VStack {
                    NavigationLink(destination: OptionsView(optionsViewShown: $optionsViewShown), isActive: $optionsViewShown) {
                        Image(systemName: "slider.horizontal.3").foregroundColor(Color.gray)
                    }
                    .frame(width: 16, height: 16)
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: WKInterfaceDevice.current().screenBounds.width, alignment: .trailing)
                .position(x: WKInterfaceDevice.current().screenBounds.width * 0.4, y: WKInterfaceDevice.current().screenBounds.height * 0.1)
            }
            
            TimerView(timerModel: TimerModel(time: 25, unit: .min, timerType: isActive ? .pomo : .stop, isActive: self.isActive))
            
            Divider()
            
            VStack {
                Button("Skip", action: skipTimer).frame(width: 80, height: 40).padding(4)
                
                HStack {
                    Button(isActive ? "Pause" : "Start", action: isActive ? pauseTimer : startTimer)
                        .frame(width: 80, height: 40).padding(4)
                    Button("Cancel", action: cancelTimer)
                        .frame(width: 80, height: 40).padding(4)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView(pomodoroTimer: TimerModel.allTimerValues()[2], shortBreakTimer: TimerModel.allTimerValues()[0], longBreakTimer: TimerModel.allTimerValues()[1])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
