//
//  TimerModel.swift
//  pomodoro WatchKit Extension
//
//  Created by Joel de León on 12/10/21.
//

import Foundation

struct TimerModel {
    var time: Int
    var timeTitle: String {
        return "\(time)"
    }
    
    var unit: TimerUnit
    var unitTitle: String {
        if time > 1 {
            return unit.plural()
        }
        
        return unit.rawValue
    }
    
    var timerType: TimerType
    var isActive: Bool
    
    
    init(time: Int, unit: TimerUnit, timerType: TimerType, isActive: Bool = false) {
        if time >= 60 {
            self.time = time / 60
            self.unit = .hr
        } else {
            self.time = time
            self.unit = unit
        }
        
        self.timerType = timerType
        self.isActive = isActive
    }
    
    static func allTimerValues() -> [TimerModel] {
        return [
            TimerModel(time: 5, unit: .min, timerType: .short),
            TimerModel(time: 20, unit: .min, timerType: .long),
            TimerModel(time: 25, unit: .min, timerType: .pomo),
        ]
    }
    
    enum TimerUnit: String {
        case min = "MIN"
        case hr = "HR"
        
        func plural() -> String {
            switch self {
            case .min:
                return "MINS"
            case .hr:
                return "HRS"
            }
        }
    }
    
    enum TimerType: String {
        case short = "SHORTBREAKTIMER"
        case long = "LONGBREAKTIMER"
        case pomo = "POMODOROTIMER"
        case stop = "STOP"
    }
}
