//
//  SearchView.swift
//  Messenger
//
//  Created by Yuying Li on 2021-06-18.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var searchContent: String = ""
    
    let userNames = ["Julia"]
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
                        
                    }.padding()
                }
                
                
            }
            List {
                ForEach(userNames, id: \.self) { name in
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

