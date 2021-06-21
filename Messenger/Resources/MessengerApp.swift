//
//  MessengerApp.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

@main
struct MessengerApp: App {
    var body: some Scene {
        WindowGroup {
            ConversationListView()
                .environmentObject(AppStateModel())
            
        }
    }
}
