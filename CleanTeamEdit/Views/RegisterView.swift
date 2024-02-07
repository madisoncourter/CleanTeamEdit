//
//  RegisterView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct RegisterView: View {

    @StateObject var viewModel = RegisterViewViewModel()
    var body: some View {
        ZStack{
            Color("Tidy")
            .ignoresSafeArea()
            .overlay(
        VStack {
            //HeaderView(title: "Register", angle: -15, background: .teal)
            HeaderView(title: "Register", subtitle: "Let's get started!")
            //.padding(.leading,50)
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .listRowBackground(Color("Tidy"))
                    .foregroundColor(Color("Serenity"))
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .listRowBackground(Color("Tidy"))
                    .foregroundColor(Color("Serenity"))
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .listRowBackground(Color("Tidy"))
                    .foregroundColor(Color("Serenity"))
                
                CTButton(
                    title: "Create Account",
                    background: Color("Dependability")
                ) {
                    viewModel.register()
                }
                .listRowBackground(Color("Tidy"))
                .padding()
            }
            .background(Color("Tidy"))
            .scrollContentBackground(.hidden)
            .offset(y: -70)
            
            VStack {
                Text("Already have an account?")
                    .foregroundColor(Color("Serenity"))
                NavigationLink("Log In", destination: LoginView())
                    .foregroundColor(Color("Dependability"))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 50)
            
            
            Spacer()
            
        }
        )
    }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
