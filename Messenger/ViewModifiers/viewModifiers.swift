//
//  viewModifiers.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-21.
//

import Foundation
import SwiftUI

struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}
