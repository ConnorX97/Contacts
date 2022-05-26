//
//  ContactsApp.swift
//  Contacts
//
//  Created by Sherzod Fayziev on 2022/05/26.
//

import SwiftUI
import Firebase

@main
struct ContactsApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            StarterScreen().environmentObject(SessionsStore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
