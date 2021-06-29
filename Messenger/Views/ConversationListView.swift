//
//  ConversationListView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var model: AppStateModel
    @State var username: String = ""
    @State var showChat: Bool = false
    @State var showSearch: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(model.conversations, id: \.self) { name in
                    NavigationLink(
                        destination: ChatView(otherUsername: name),
                        label: {
                            HStack {
                                Circle()
                                    .frame(width: 65, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.pink)
                                
                                Text(name)
                                    .bold()
                                    .foregroundColor(Color(.label))
                                    .font(.system(size: 32))
                                
                                Spacer()
                            }.padding()
                        })
                    
                }
                if !username.isEmpty {
                    NavigationLink(
                        destination: ChatView(otherUsername: username),
                        isActive: $showChat,
                        label: {
                            Text("")
                        })
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button("Sign Out") {
                        self.signOut()
                    }
                }
                
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(
                        destination: SearchView {name in
                            self.showSearch = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.username = name
                                self.showChat = true
                            }
                        },
                        isActive: $showSearch,
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                }
            }
            .fullScreenCover(isPresented: $model.showSignInView, content: {
                SignInView()
            })
            .onAppear {
                guard model.auth.currentUser != nil else {
                    return
                }
                model.getConversations()
            }
            
        }
    }
    
    func signOut() {
        model.signOut()
    }
}


