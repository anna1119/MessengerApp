//
//  ChatRow.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct ChatRow: View {
    
    let type: MessageType
    let text: String
    
    var isSender: Bool {
        return type == .sent
    }
    
    init(type: MessageType, text: String) {
        self.type = type
        self.text = text
    }
    
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            
            if !isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.pink)
                }
            }
            
            HStack {
                Text("Hello")
                    .foregroundColor(isSender ? Color.white : Color(.label))
                    .padding()
                    
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .cornerRadius(6)
            .padding(isSender ? .leading : .trailing, isSender ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width / 5)
            
            
            if isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.yellow)
                }
            }
            
            if !isSender {
                Spacer()
            }
        }
    }
}

