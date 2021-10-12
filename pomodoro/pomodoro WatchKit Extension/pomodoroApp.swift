//
//  pomodoroApp.swift
//  pomodoro WatchKit Extension
//
//  Created by Joel de León on 11/10/21.
//

import SwiftUI

@main
struct pomodoroApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
