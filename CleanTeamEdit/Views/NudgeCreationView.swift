
//
//  NudgeCreationView.swift
//  Nudge Messaging
//
//  Created by Madison  Courter on 11/30/23.
//
import SwiftUI

struct NudgeCreationView: View {
    @StateObject private var nudgeCreationViewModel = NudgeCreationViewModel()
    @State private var selectedCategory: ChoreCategory?
    @State private var selectedRoommate: String?

    var body: some View {
        ZStack{
            Color("Tidy")
            .ignoresSafeArea()
            .overlay(
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Someone slacking? Don't be shy, give them a nudge.")
                    .font(Font.custom("Montserrat-Medium", size: 20))
                    .padding(.top,5)
                    .padding(.horizontal,10)
                
                // Roommates
                HStack{
                    Text("Teammates")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color("Serenity"))
                        .padding(.horizontal,20)
                        .padding(.top,20)
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    ForEach(nudgeCreationViewModel.roommates, id: \.self) { roommate in
                        Button(action: {
                            selectedRoommate = roommate
                        }) {
                            VStack{
                                Circle()
                                    .fill(Color("Harmony")) //Change to Harmoy
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: "person.fill") // Replace with SF symbol representing the roommate
                                            .foregroundColor(Color("Tidy"))
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(selectedRoommate == roommate ? Color.black : Color.clear, lineWidth: 2)
                                    )
                                Text(roommate)
                                    .foregroundColor(Color("Serenity"))
                                    .font(Font.custom("Montserrat-Regular", size: 16))
                            }
                        }
                    }
                }
                .padding()
                
                // Chore Categories
                HStack{
                    Text("Prompts By Category")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color("Serenity"))
                        .padding(.horizontal,20)
                        .padding(.top,20)
                    
                    Spacer()
                }
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(nudgeCreationViewModel.choreCategories) { category in
                                NavigationLink(destination: NudgePromptSelectionView(category: category, viewModel: nudgeCreationViewModel, selectedCategory: $selectedCategory, selectedRoommate: $selectedRoommate)) {
                                    VStack {
                                        Image(category.image)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .overlay(
                                                Circle()
                                                    .stroke(selectedCategory?.id == category.id ? Color("Serenity") : Color.clear, lineWidth: 2)
                                            )
                                        Text(category.name)
                                            .font(Font.custom("Montserrat-Regular", size: 16))
                                            .foregroundColor(Color("Serenity"))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    Spacer() // Add Spacer to center the images vertically
                }
            }


            }
            .navigationTitle("Create New Nudge")
                )
            }
    }
}


class IdentifiableString: Identifiable {
    let id = UUID()
    let value: String
    var selectedRoommate: String?
    init(_ value: String) {
        self.value = value
    }
}

struct ChoreCategory: Identifiable {
    var id: UUID = UUID()
   // var color: Color
    var name: String
    var image: String
    var prompts: [String]
}

/*struct NudgePromptSelectionView: View {
    var category: ChoreCategory
    @ObservedObject var viewModel: NudgeCreationViewModel
    @Binding var selectedCategory: ChoreCategory?
    @Binding var selectedRoommate: String?

    @State private var selectedPrompt: IdentifiableString?
    @State private var isActionSheetPresented = false
    @State private var isSentConfirmationVisible = false


    var body: some View {
        ScrollView {
            ForEach(category.prompts, id: \.self) { prompt in
                VStack {
                    HStack {
                        Text(prompt)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                                    .shadow(radius: 3)
                                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: .infinity)
                            )
                            .onTapGesture {
                                selectedPrompt = IdentifiableString(prompt)
                                isActionSheetPresented = true

                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(selectedPrompt?.value == prompt ? Color("Serenity") : Color.clear, lineWidth: 2)
                            )
                        Image("DisappointedTerry") // Replace with your turtle image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)

                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                }

                .padding(.vertical, 8)

            }
        }
        .background(Color.gray.opacity(0.1)) // Adjust background color as needed
        .navigationTitle(category.name)
        //.navigationBarItems(trailing: sendButton)
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(
                title: Text("Send to \(selectedRoommate ?? "Teammate")?"),
                buttons: [
                    .default(Text("Send")) {
                        // Add your message sending logic here
                        if let prompt = selectedPrompt?.value, let roommate = selectedRoommate {
                            let sender = "Anonymous" // Replace with actual sender's identifier
                            viewModel.sendMessage(sender: sender, text: prompt, to: roommate)
                            isSentConfirmationVisible = true
                        }
                        selectedRoommate = nil
                    },
                    .cancel()
                ]
            )
        }
        .overlay(
            VStack {
                if isSentConfirmationVisible {
                            Text("Message sent!")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green) // Customize the color
                                .cornerRadius(50)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        }
                    }
                , alignment: .bottom
        )
    }

    /*var sendButton: some View {
        Button(action: {
            isActionSheetPresented = true
        }) {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }
    }*/
}*/

struct NudgePromptSelectionView: View {
    var category: ChoreCategory
    @ObservedObject var viewModel: NudgeCreationViewModel
    @Binding var selectedCategory: ChoreCategory?
    @Binding var selectedRoommate: String?

    @State private var selectedPrompt: IdentifiableString?
    @State private var isActionSheetPresented = false
    @State private var isSentConfirmationVisible = false
    @State private var customPrompt: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("Premade Messages")
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .foregroundColor(Color("Serenity"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top,10)
                ForEach(category.prompts, id: \.self) { prompt in
                    VStack {
                        HStack {
                            Text(prompt)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color.white)
                                        .shadow(radius: 3)
                                )
                                .onTapGesture {
                                    selectedPrompt = IdentifiableString(prompt)
                                    isActionSheetPresented = true
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(selectedPrompt?.value == prompt ? Color("Serenity") : Color.clear, lineWidth: 2)
                                )
                            
                            Image("DisappointedTerry") // Replace with your turtle image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .padding(.vertical, 8)
                }
                VStack{
                    Text("Custom Message")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color("Serenity"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top,10)
                HStack{
                    TextField("Write your own message", text: $customPrompt)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)
                        .foregroundColor(Color("Serenity"))
                    Text ("Send")
                        .onTapGesture {
                            selectedPrompt = IdentifiableString(customPrompt)
                            isActionSheetPresented = true
                        }
                        .font(Font.custom("Montserrat-Medium",size:20))
                        .foregroundColor(Color("Dependability"))
                }
                .padding(.horizontal)
            }
            }
        }
        .background(Color.gray.opacity(0.1)) // Adjust background color as needed
        .navigationTitle(category.name)
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(
                title: Text("Send to \(selectedRoommate ?? "Teammate")?"),
                buttons: [
                    .default(Text("Send")) {
                        // Add your message sending logic here
                        let promptToSend = customPrompt.isEmpty ? selectedPrompt?.value : customPrompt
                        if let prompt = promptToSend, let roommate = selectedRoommate {
                            let sender = "Anonymous" // Replace with actual sender's identifier
                            viewModel.sendMessage(sender: sender, text: prompt, to: roommate)
                            isSentConfirmationVisible = true
                            customPrompt = ""
                        }
                        selectedRoommate = nil
                    },
                    .cancel()
                ]
            )
        }
        .overlay(
            VStack {
                if isSentConfirmationVisible {
                    Text("Message sent!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green) // Customize the color
                        .cornerRadius(50)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                }
            }
            , alignment: .bottom
        )
    }
}


#Preview {
    NudgeCreationView()
}
