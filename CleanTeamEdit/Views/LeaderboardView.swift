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
                    VStack(spacing: 20) { // Adjust the spacing between elements
                           Text("Leaderboard")
                                .font(Font.custom("Montserrat-SemiBold", size: 30))
                                .foregroundColor(Color("Harmony"))
                               .multilineTextAlignment(.leading)
                            
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
                                    .cornerRadius(10)
                            }
                        }
                        .listRowInsets(EdgeInsets()) // Remove extra padding from List rows
                        .background(Color("Tidy"))
                        
                        VStack(alignment: .leading) {
                            Text("This Cycle Goal")
                                .font(Font.custom("Montserrat-Medium",size:23))
                                .foregroundColor(Color("Serenity"))
                                .padding(.bottom)
                            Text("Competing to Reach 200 Points")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                                .padding(.bottom)
                            Text("Cycle \(displayMode == .rewards ? "Reward" : "Punishment"): \(displayMode == .rewards ? selectedReward : selectedPunishment)")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Enthusiasm"))
                        }
                        //testing github!
                        // Button
                            HStack{
                                VStack{
                                    CTButton(title: "View Options", background: Color("Dependability")) {
                                        showRewards.toggle()
                                    }
                                    .frame(width:300, height:80)
                                    .padding(.bottom, 50.0)
                                }
                                .font(Font.custom("Montserrat-Medium",size:15))
                
                                    .frame(height: 140.0)
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
                            .font(Font
                            .custom("Montserrat-Regular",size:18))
                            .foregroundColor(Color("Dependability"))
                            
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


