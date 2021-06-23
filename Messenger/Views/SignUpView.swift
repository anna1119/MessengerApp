//
//  SignUpView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var model: AppStateModel
    var body: some View {
            VStack {
                // Heading
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                
                Text("Create Account")
                    .bold()
                    .font(.system(size: 34))
                
                
                // Textfields
                VStack {
                    TextField("Email Address", text: $email)
                        .modifier(CustomField())
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                    
                    Button(action: {
                        self.signIn()
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .frame(width: 220, height: 50)
                            .background(Color.green)
                            .cornerRadius(6)
                    })
                }.padding()
                
                
                
                
                Spacer()
                
                
            }.navigationBarTitle("Create Account", displayMode: .inline)
        
        
    }
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            return
        }
        
        
    }
}
