//
//  HydroBerryApp.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//


import Firebase
import SwiftUI

@main
struct HydroBerryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
           SplashScreenView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
