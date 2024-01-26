//
//  LoginView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct LoginView: View {
    
@StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Tidy")
                .ignoresSafeArea()
                .overlay(
            VStack {
                //Header
                /*Image("HorizontalWordmark")
                 .padding(.leading,70)*/
                
                // HeaderView(title: "Login", angle: 15, background: .blue)
                HeaderView(title: "Login", subtitle:"Welcome Back!")
                
                //Login
                
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .listRowBackground(Color("Tidy"))
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .listRowBackground(Color("Tidy"))
                    CTButton(
                        title: "Login",
                        background: Color("Dependability")
                    ) {
                        viewModel.login()
                    }
                    .padding()
                    .listRowBackground(Color("Tidy"))
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                            .listRowBackground(Color("Tidy"))
                    }
                }
                .background(Color("Tidy"))
                .scrollContentBackground(.hidden)
                .offset(y: -50)
                
                
                
                //Create Account
                VStack {
                    Text("New to CleanTeam?")
                        .foregroundColor(Color("Serenity"))
                    NavigationLink("Create New Account", destination: RegisterView())
                        .foregroundColor(Color("Dependability"))
                        .fontWeight(.bold)
                }
                .padding(.bottom, 50)
                
                
                Spacer()
            }
            .font(Font.custom("Montserrat-Medium", size: 17))
            )
        }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
