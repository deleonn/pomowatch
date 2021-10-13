//
//  TimerView.swift
//  pomodoro WatchKit Extension
//
//  Created by Joel de León on 12/10/21.
//

import SwiftUI

struct TimerView: View {
    var timeRemaining: CGFloat
    var timerModel: TimerModel
    
    @State private var counter: CGFloat
    @Environment(\.presentationMode) var presentationMode
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    private var formattedTime: String {
        return formatter.string(from: TimeInterval(counter))!
    }
    
    func returnColorByType() -> Color {
        switch self.timerModel.timerType {
        case .stop:
            return Color.gray
        case .long:
            return Color.purple
        case .short:
            return Color.blue
        case .pomo:
            return Color.green
        }
    }
    
    init(timerModel: TimerModel) {
        if timerModel.unit == .hr {
            self.timeRemaining = CGFloat(timerModel.time * 60 * 60)
        } else {
            self.timeRemaining = CGFloat(timerModel.time * 60)
        }
    
        self.timerModel = timerModel
        _counter = State(initialValue: self.timeRemaining)
    }
    
    var body: some View {
        ZStack {
            Text(formattedTime)
                .font(.title2)
                .foregroundColor(returnColorByType())
                .onReceive(timer, perform: { _ in
                    if counter > 0 && timerModel.isActive {
                        counter -= 1
                    }
                }).padding()
            
            if counter <= 0 {
                Text("0:00")
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerModel: TimerModel(time: 25, unit: .min, timerType: .pomo))
    }
}


//Text(pomodoroTimer.timeTitle)
//    .padding(0)
//    .font(.system(size: 40))
//    .foregroundColor(returnColorByType()).onReceive(timer) { time in
//        if self.timeRemaining > 0 && self.counterActive {
//            self.timeRemaining -= 1
//        } else if self.timeRemaining == 0 && self.counterActive {
//            skipTimer()
//            WKInterfaceDevice.current().play(.notification)
//            WKInterfaceDevice.current().play(.notification)
//            WKInterfaceDevice.current().play(.notification)
//        }
//    }
