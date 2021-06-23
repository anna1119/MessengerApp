//
//  Message.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import Foundation

enum MessageType: String {
    case sent
    case received
}

struct Message {
    let text: String
    let type: MessageType
    let created: String // Date
}
