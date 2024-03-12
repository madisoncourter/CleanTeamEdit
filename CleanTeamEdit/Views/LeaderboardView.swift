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
        NavigationView{
            ZStack{
                Color("Tidy")
                    .ignoresSafeArea()
                Image("UpwardRoundedAccentDarkCropped")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //.frame(width:350, height:350)
                    .offset(x:-20,y:180)
                    .opacity(0.5)
                    .colorMultiply(Color("Tidy")) // Set the tint color
                
                ScrollView{
                    VStack (spacing: 20) { // Adjust the spacing between elements
                        //List(leaderData.leaders.sorted { $0.points > $1.points }) { leader in
                        ForEach(leaderData.leaders.sorted { $0.points > $1.points }) { leader in
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
                                .padding(.bottom,-5)
                                
                                GeometryReader { geometry in
                                    Rectangle()
                                        .fill(Color("Enthusiasm"))
                                        .frame(width: mapPointsToWidth(points: leader.points), height: 15)
                                        .cornerRadius(10)
                                }
                                .padding()
                                .listRowSeparatorTint(Color.white)
                            }
                        }
                        .scrollIndicators(ScrollIndicatorVisibility.hidden)
                        .listStyle(PlainListStyle())
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .listRowInsets(EdgeInsets()) // Remove extra padding from List rows
                        .background(Color("Tidy"))
                        .padding(.top,10)
                        
                        /*VStack (alignment:.leading){
                         Text("Rewards & Punishments")
                         .font(Font.custom("Montserrat-SemiBold", size: 20))
                         .foregroundColor(Color("Serenity"))
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
                         .padding(25)
                         .padding(.horizontal,10)
                         }*/
                        
                        HStack{
                            Text("Rewards & Punishments")
                                .padding(.top,20)
                                .font(Font.custom("Montserrat-SemiBold", size: 20))
                                .foregroundColor(Color("Serenity"))
                                .padding(.horizontal,20)
                            Spacer()
                        }
                        
                        VStack {
                            Text("Cycle \(displayMode == .rewards ? "Reward" : "Punishment")")
                                .font(Font.custom("Montserrat-SemiBold", size: 23))
                                .foregroundColor(Color("Serenity"))
                                .padding(.bottom,5)
                            Text("\(displayMode == .rewards ? selectedReward : selectedPunishment)")
                                .font(Font.custom("Montserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .padding(10)
                        .background(Color("Serenity").opacity(0.15))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom,-12)
                        
                        HStack{
                            VStack {
                                Text("Cycle Goal")
                                    .font(Font.custom("Montserrat-SemiBold", size: 23))
                                    .foregroundColor(Color("Tidy"))
                                Text("200")
                                    .font(Font.custom("Montserrat-SemiBold", size: 40))
                                    .fontWeight(.black)
                                    .foregroundColor(Color("Tidy"))
                                Text("points")
                                    .font(Font.custom("Montserrat-Medium", size: 15))
                                    .foregroundColor(Color("Tidy"))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .padding(10)
                            .padding(.vertical,30)
                            .background(Color("Dependability").opacity(0.70))
                            .cornerRadius(10)
                            
                            ZStack{
                                VStack {
                                    ZStack {
                                        Circle()
                                            .stroke(Color(.clear), lineWidth: 7)
                                            .frame(width: 125, height: 125)
                                        Circle()
                                            .trim(from: 0, to: 0.85)
                                            .stroke(.white, lineWidth: 7)
                                            .frame(width: 125, height: 125)
                                            .overlay {
                                                VStack {
                                                    Text("85%")
                                                        .font(Font.custom("Montserrat-SemiBold", size: 30))
                                                        .foregroundColor(Color("Tidy"))
                                                    Text("Complete")
                                                        .font(Font.custom("Montserrat-Medium", size: 15))
                                                        .foregroundColor(Color("Tidy"))
                                                }
                                            }
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .padding(10)
                                .padding(.vertical,20)
                                .background(Color("Serenity").opacity(0.70))
                                .cornerRadius(10)
                                
                                Text("Almost there!")
                                    .font(Font.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(.white)
                                    .padding(7)
                                    .background(Color("Enthusiasm").opacity(0.95))
                                    .offset(y:90)
                            }
                        }
                        .padding(.horizontal)
                        
                        //testing github!
                        // Button
                        HStack{
                            VStack{
                                CTButton(title: "Add New ", background: Color("Dependability")) {
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
                }
                .scrollIndicators(ScrollIndicatorVisibility.hidden)

                }
                .navigationTitle("Leaderboard")

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


