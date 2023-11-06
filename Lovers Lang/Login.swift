//
//  Login.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/5/23.
//

import SwiftUI

struct Login: View {
    @State var username: String = ""
    @State var password: String = ""
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    
    var body: some View {
        VStack{
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button(action: {
                
            }, label: {
                Text("Sign In").background(in: .buttonBorder)
            })
            HStack {
                Button("Create An Account", action: {
                    
                })
                Divider()
                Button("Continue As Guest", action: {
                    
                })
            }.frame(width: screenWidth * 0.9, height: screenHeight * 0.1, alignment: .center)
        }.frame(width: screenWidth * 0.9, alignment: .center)
        
    }
}

#Preview {
    Login()
}
