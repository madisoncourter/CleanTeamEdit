//
//  RewardsPage.swift
//  CleanTeamEdit
//
//  Created by NMI Class on 12/5/23.
//
//RewardsPage
import SwiftUI
enum DisplayMode {
    case rewards
    case punishments
}
struct Reward: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}
struct Punishment: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}
//Start RewardsPage View
struct RewardsPage: View {
//Variables allow user to select item & pass info to leaderboard
    @Binding var selectedReward: String
    @Binding var selectedPunishment: String
    @Binding var displayMode: DisplayMode
    
    var didSelectReward: (String) -> Void
    var didSelectPunishment: (String) -> Void
    var didSelectType: (DisplayMode) -> Void
   
    @State private var rewards: [Reward] = [
        Reward(title: "Free dinner from roomies"),
        Reward(title: "Free ride to next party"),
        Reward(title: "Control TV one Saturday"),
        Reward(title: "Get out of next trash duty"),
        // Add more rewards as needed
    ]
    @State private var punishments: [Punishment] = [
        Punishment(title: "Designated driver duty"),
        Punishment(title: "Pay next grocery bill"),
        Punishment(title: "Buy round of drinks"),
        Punishment(title: "Clean up after next party"),
        // Add more punishments as needed
    ]
//Allow users to create their own
    @State private var newRewardText = ""
    @State private var newPunishmentText = ""
    
    //Navigation Title Color
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(displayMode == .rewards ? "Rewards" : "Punishments")
                     .font(Font.custom("Montserrat-SemiBold", size: 30))
                     .foregroundColor(Color("Harmony"))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20.0)
                //toggles between rewards & punishments
                Picker("Display Mode", selection: $displayMode) {
                    Text("Rewards").tag(DisplayMode.rewards)
                        .font(Font.custom("Montserrat-Medium",size:15))
                    Text("Punishments").tag(DisplayMode.punishments)
                        .font(Font.custom("Montserrat-Medium",size:15))
                }
                .font(Font.custom("Montserrat-Medium",size:15))
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    if displayMode == .rewards {
                        Text("Select a reward for this cycle's winner")
                            .font(Font.custom("Montserrat-Medium",size:18))
                        ForEach($rewards) { $reward in
                            RewardRow(reward: $reward,rewards: $rewards, selectedReward: $selectedReward, didSelectReward: didSelectReward)
                        }
                        VStack(alignment:.leading){
                            Text("Create a new reward:")
                                .font(Font.custom("Montserrat-Medium",size:18))
                            
                            HStack{
                                TextField("New Reward", text: $newRewardText)
                                    .font(Font.custom("Montserrat-Regular",size:15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                Button(action: {
                                    addNewReward()
                                }) {
                                    Text("Add New")
                                        .font(Font.custom("Montserrat-Medium",size:15))
                                        .foregroundColor(Color("Dependability"))
                                    
                                }
                            }
                        }
                        
                    } else {
                        Text("Select a punishment for this cycle's loser")
                            .font(Font.custom("Montserrat-Medium",size:18))
                        ForEach($punishments) { $punishment in
                    PunishmentRow(punishment: $punishment, punishments: $punishments,selectedPunishment: $selectedPunishment, didSelectPunishment: didSelectPunishment)
                        }
                        VStack(alignment: .leading){
                            Text("Create a new punishment.")
                                .font(Font.custom("Montserrat-Medium",size:18))
                            HStack{
                                TextField("New Punishment", text: $newPunishmentText)
                                    .font(Font.custom("Montserrat-Regular",size:15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                Button(action: {
                                    addNewPunishment()
                                }) {
                                    Text("Add New")
                                        .font(Font.custom("Montserrat-Medium",size:15))
                                        .foregroundColor(Color("Dependability"))
                                    
                                }
                            }
                        }
                        
                    }
                    
                }
                .padding(.bottom)
            }
         //   .navigationTitle(displayMode == .rewards ? "Rewards" : "Punishments")
        }
    }
    
    func addNewReward() {
        guard !newRewardText.isEmpty else { return }
        rewards.append(Reward(title: newRewardText))
        newRewardText = "" // Reset the text field after adding the new reward
    }
    func addNewPunishment() {
        guard !newPunishmentText.isEmpty else { return }
        punishments.append(Punishment(title: newPunishmentText))
        newPunishmentText = "" // Reset the text field after adding the new punishment
    }
}
struct RewardRow: View {
        @Binding var reward: Reward
        @Binding var rewards: [Reward]
        @Binding var selectedReward: String
    var didSelectReward: (String) -> Void
        var body: some View {
            HStack {
                Text(reward.title)
                    .font(Font.custom("Montserrat-Regular",size:16))
                    .foregroundColor(reward.isSelected ? Color("Enthusiasm") : Color.primary)
                
                Spacer()
                if reward.isSelected {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("Enthusiasm"))
                } else {
                    Image(systemName: "square")
                        .foregroundColor(.primary)
                }
            }
            .onTapGesture {
                selectReward(&reward)
            }
        }
    //makes selection & pushes to leaderboard
        private func selectReward(_ selectedReward: inout Reward) {
            self.selectedReward = selectedReward.title
            didSelectReward(selectedReward.title)
            rewards.indices.forEach { index in
                if rewards[index].id != selectedReward.id {
                    rewards[index].isSelected = false
                }
            }
            selectedReward.isSelected.toggle()
        }
    }
struct PunishmentRow: View {
    @Binding var punishment: Punishment
    @Binding var punishments: [Punishment]
    @Binding var selectedPunishment: String
    var didSelectPunishment: (String) -> Void
    var body: some View {
        HStack {
            Text(punishment.title)
                .font(Font.custom("Montserrat-Regular",size:16))
                .foregroundColor(punishment.isSelected ? Color("Enthusiasm") : Color.primary)
            
            Spacer()
            if punishment.isSelected {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(.red)
            } else {
                Image(systemName: "square")
                    .foregroundColor(.primary)
            }
        }
        .onTapGesture {
            selectPunishment(&punishment)
        }
    }
    
    //makes selection & pushes to leaderboard
    private func selectPunishment(_ selectedPunishment: inout Punishment) {
            self.selectedPunishment = selectedPunishment.title
            didSelectPunishment(selectedPunishment.title)
            punishments.indices.forEach { index in
                if punishments[index].id != selectedPunishment.id {
                    punishments[index].isSelected = false
                }
            }
            selectedPunishment.isSelected.toggle()
        }
    }
//Preview Structure w/ Variables
struct RewardsPage_Previews: PreviewProvider {
    static var previews: some View {
        RewardsPage(
            selectedReward: .constant(""),
            selectedPunishment: .constant(""),
            displayMode: .constant(.rewards), // Provide a constant value for displayMode
            didSelectReward: { _ in },
            didSelectPunishment: { _ in },
            didSelectType: { _ in }
        )
    }
}
