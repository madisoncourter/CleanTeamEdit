//
//  LeaderboardView.swift
//  CleanTeamEdit
//
//  Created by NMI Student on 11/27/23.
//
import SwiftUI
struct LeaderboardView: View {
    @ObservedObject var leaderData: LeaderData
    @State private var showRewards = false
    @State private var selectedReward: String = ""
    @State private var displayMode: DisplayMode = .rewards // Declare displayMode
    @State private var selectedPunishment: String = "" // Declare selectedPunishment
    
    
    var body: some View {
        ZStack{
            Color("Tidy")
                .ignoresSafeArea()
                .overlay(
                    VStack(spacing: 10) { // Adjust the spacing between elements
                        HStack {
                            Text("Leaderboard")
                                .font(.largeTitle)
                                .multilineTextAlignment(.leading)
                            Image(systemName: "rosette")
                                .font(.title)
                        }
                        .padding(.top, 35)
                        
                        List(leaderData.leaders.sorted { $0.points > $1.points }) { leader in
                            VStack{
                            HStack {
                                Image(systemName: leader.imageName)
                                    .foregroundColor(Color("Harmony"))
                                    .font(.largeTitle)
                                    Text(leader.name)
                                        .font(Font.custom("Montserrat-Medium",size:18))
                                        .foregroundColor(Color("Serenity"))
                                    Spacer()
                                    Text("\(leader.points) points")
                                        .font(Font.custom("Montserrat-Regular",size:18))
                                        .foregroundColor(Color("Serenity"))
                                }
                               // .padding(.top)
                            }
                            GeometryReader { geometry in
                                Rectangle()
                                    .fill(Color("Enthusiasm"))
                                    .frame(width: mapPointsToWidth(points: leader.points), height: 15)
                            }
                        }
                        .listRowInsets(EdgeInsets()) // Remove extra padding from List rows
                       
                        
                        VStack(alignment: .leading) {
                            Text("This Cycle Goal")
                                .font(Font.custom("Montserrat-Medium",size:23))
                                .foregroundColor(Color("Serenity"))
                            Text("Competing to Reach 200 Points")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                            Text("Cycle \(displayMode == .rewards ? "Reward" : "Punishment"): \(displayMode == .rewards ? selectedReward : selectedPunishment)")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                            
                            
                        }
                        Button(action: {
                            showRewards.toggle()
                        }) {
                            Text("Select Reward/Punishment")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Dependability"))
                        }
                        .sheet(isPresented: $showRewards) {
                            RewardsPage(selectedReward: $selectedReward, selectedPunishment:$selectedPunishment,displayMode: $displayMode, didSelectReward: { reward in
                                selectedReward = reward // Update the selected reward
                            },
                                        didSelectPunishment: { punishment in selectedPunishment = punishment
                            },
                                        didSelectType: { type in
                                displayMode = type // Update the selected type (reward or punishment)
                            })
                        }
                        
                    }
                )
        }
    }
}
    
    func mapPointsToWidth(points: Int) -> CGFloat {
        let ratio = CGFloat(points) / CGFloat(200)
        return ratio * UIScreen.main.bounds.width * 0.8
    }
    
    
    struct LeaderboardView_Previews: PreviewProvider {
        static var previews: some View {
            LeaderboardView(leaderData: LeaderData())
        }
    }


