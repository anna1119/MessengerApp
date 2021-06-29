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
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    // Current user being chatted with
    
    // Message, Conversations
    
    init() {
        self.showSignInView = Auth.auth().currentUser == nil
    }
}


// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        db.collection("users").getDocuments {snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({$0.documentID}), error == nil else {
                completion([])
                return
            }
            let filtered = usernames.filter({$0.lowercased().hasPrefix(queryText.lowercased())})
            completion(filtered)
        }
    }
}


// Conversations
extension AppStateModel {
    func getConversations() {
        // Listen for conversations
        conversationListener = db.collection("users").document(currentUsername).collection("chats").addSnapshotListener {snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({$0.documentID}), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.conversations = usernames
            }
        }
    }
}

// Get Chat/Send messages

extension AppStateModel {
    func observeChat() {
        createConversation()
        chatListener = db.collection("users").document(currentUsername).collection("chats").document(otherUsername).collection("messages").addSnapshotListener {snapshot, error in
            guard let objects = snapshot?.documents.compactMap({$0.data()}), error == nil else {
                return
            }
            let messages: [Message] = objects.compactMap({
                guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                    return nil
                }
                return Message(text: $0["text"] as? String ?? "", type: $0["sender"] as? String == self.currentUsername ? .sent : .received, created: date)
            }).sorted(by: {first, second in
                return first.created < second.created
                
            })
            
            DispatchQueue.main.async {
                self.messages = messages
            }
        }
    }
    
    func sendMessage(text: String) {
        let newMessageId = UUID().uuidString
        
        let data = ["text": text, "sender": currentUsername, "created": ISO8601DateFormatter().string(from: Date()) ]
        
        db.collection("users").document(currentUsername).collection("chats").document(otherUsername).collection("messages").document(newMessageId).setData(data)
        
        db.collection("users").document(otherUsername).collection("chats").document(currentUsername).collection("messages").document(newMessageId).setData(data)
    }
    
    func createConversation() {
        db.collection("users").document(currentUsername).collection("chats").document(otherUsername).setData(["created": "true"])
        db.collection("users").document(otherUsername).collection("chats").document(currentUsername).setData(["created": "true"])
    }
}

// Sign in & Sign up
extension AppStateModel {
    func signIn(username: String, password: String) {
        // Get Email from db
        db.collection("users").document(username).getDocument {snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                return
            }
            self.auth.signIn(withEmail: email, password: password, completion: {result, error in
                guard error == nil, result != nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.currentEmail = email
                    self.currentUsername = username
                    self.showSignInView = false
                }
                
            })
            
        }
        
        // try to sign in
        
       
    }
    func signUp(email: String, username: String, password: String) {
        // Create Account
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
        }
        
        // Insert username into database
        let data = ["email" : email, "username": username]
        
        self.db.collection("users").document(username).setData(data) {error in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.currentUsername = username
                self.currentEmail = email
                self.showSignInView = false
            }
        }
    }
    func signOut() {
        do {
            try auth.signOut()
            self.showSignInView = true
        }
        catch {
            print(error)
        }
    }
}
