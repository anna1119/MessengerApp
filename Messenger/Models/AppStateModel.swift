//
//  AppStateModel.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    // Is user signed in
    @Published var showSignInView: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    var otherUsername: String = ""
    // Current user being chatted with
    
    // Message, Conversations
}


// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        
    }
}


// Conversations
extension AppStateModel {
    func getConversations() {
        // Listen for conversations
    }
}

// Get Chat/Send messages

extension AppStateModel {
    func observeChat() {
        
    }
    
    func sendMessage(text: String) {
        
    }
    
    func createConversationIfNeeded() {
        
    }
}

// Sign in & Sign up
extension AppStateModel {
    func signIn(username: String, password: String) {
        
    }
    func signUp(email: String, username: String, password: String) {
        
    }
    func signOut() {
        
    }
}
