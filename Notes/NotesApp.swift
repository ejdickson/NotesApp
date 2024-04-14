//
//  NotesApp.swift
//  Notes
//
//  Created by Emma Brennan on 4/14/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Auth.auth()

    return true
  }
}

@main
struct NotesApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      var body: some Scene {
        WindowGroup {
          NavigationView {
            AuthenticatedView {
              Text("Welcome to Notes!")
                .font(.title)
              Text("You need to be logged in to use this app.")
            } content: {
              NoteListView()
              Spacer()
            }
          }
        }
      }
}

