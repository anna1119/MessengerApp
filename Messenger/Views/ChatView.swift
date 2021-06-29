//
//  ChatView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct ChatView: View {
    @State var message: String = ""
    @EnvironmentObject var model: AppStateModel
    let otherUsername: String
    
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    var body: some View {
        VStack {
            ScrollView {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(type: message.type, text: message.text)
                        .padding(3)
                    
                }
                
            }
            
            // Field, send button
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButtonView(message: $message)
            }
            .padding()
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear {
            model.otherUsername = otherUsername
            model.observeChat()
        }
    }
}


