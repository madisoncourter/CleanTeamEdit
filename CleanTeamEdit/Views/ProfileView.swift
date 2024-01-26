//
//  ProfileView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    //Navigation Title Color and Font
    init() {
        // Set custom font for large title text in the navigation bar
        if let customFont = UIFont(name: "MontserratAlternates-SemiBold", size: 34.0) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor(named: "Harmony") ?? .purple,
                .font: customFont
            ]
        }
    }
    
    var body: some View {

        NavigationView {
            ZStack{
               Color("Tidy")
                .ignoresSafeArea()
            VStack{
                if let user = viewModel.user{
                    profile(user: user)
                } else {
                    Button("Log Out") {
                        viewModel.logOut()
                    }
                }
            }
            .navigationTitle("Profile")
        }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    @ViewBuilder
    func profile (user: User) -> some View{
                // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 135)
            .padding()
        //Info: Name, Email, member since
        VStack(alignment: .leading) {
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack{
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack{
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()
        //sign out
        Button("Log Out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()

        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
