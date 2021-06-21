//
//  ChatView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct ChatView: View {
    @State var message: String = ""
    var userName: String
    var body: some View {
        VStack {
            ScrollView {
                ChatRow(type: .sent, text: "Hello World")
                ChatRow(type: .received, text: "Hello World")
                
            }
            
            // Field, send button
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButtonView(message: $message)
            }
            .padding()
        }
        .navigationTitle(userName)
    }
}


