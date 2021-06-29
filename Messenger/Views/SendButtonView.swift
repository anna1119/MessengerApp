//
//  SendButtonView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct SendButtonView: View {
    @Binding var message: String
    @EnvironmentObject var model : AppStateModel
    var body: some View {
        Button(action: {
            self.sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                .font(.system(size: 33))
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Circle())
        })
    }
    func sendMessage() {
        guard !message.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        model.sendMessage(text: message)
        message = ""
    }
}
