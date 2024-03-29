//
//  ContentView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                TodoListView(userId: viewModel.currentUserId)
                    .tabItem{
                        Label("To-Do List", systemImage: "list.bullet.clipboard.fill")
                            .foregroundColor(Color("Dependability"))
                    }

                NudgeRepository()
                    .tabItem{
                        Label("Nudges", systemImage:"message.fill")
                            .foregroundColor(Color("Dependability"))
                    }
                LeaderboardView(leaderData: LeaderData())                    .tabItem{
                        Label("Leaderboard", systemImage:"chart.bar")
                        .foregroundColor(Color("Dependability"))
                    }
                ProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person.circle")
                            .foregroundColor(Color("Dependability")) 
                    }
            }
            .accentColor(Color("Dependability"))

        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
