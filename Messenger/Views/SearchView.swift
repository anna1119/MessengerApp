//
//  SearchView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: AppStateModel
    @State var searchContent: String = ""
    @State var usernames: [String] = []
    
    let completion: ((String) -> Void)
    
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            
            ZStack {
                HStack() {
                    TextField("Username...", text: $searchContent)
                        .modifier(CustomField())
                }
                
                
                HStack {
                    Spacer()
                    Button("Search") {
                        guard !searchContent.trimmingCharacters(in: .whitespaces).isEmpty else {
                            return
                        }
                        
                        model.searchUsers(queryText: searchContent) {usernames in
                            self.usernames = usernames
                            
                        }
                    }.padding()
                }
                
                
            }
            List {
                ForEach(usernames, id: \.self) { name in
                    HStack {
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color.green)
                        
                        Text(name)
                            .font(.system(size: 24))
                        
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                    
                }
            }
            
            
            
            Spacer()
        }
        .navigationTitle("Search")
    }
}

