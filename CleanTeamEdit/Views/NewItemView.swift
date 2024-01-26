//
//  NewItemView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct NewItemView: View {
    @State var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    @State var randomIsToggled = false
    @State var rotateIsToggled = false
    @State private var points = 0
    @State private var penalty = 0
    @State private var selectedCategory: String?

    let tidyColor = UIColor(red: 245/255.0, green: 246/255.0, blue: 253/255.0, alpha: 1.0)
    let harmonyColor = UIColor(red: 114/255.0, green: 132/255.0, blue: 200/255.0, alpha: 1.0)
    let serenityColor = UIColor(red: 30/255.0, green: 37/255.0, blue: 71/255.0, alpha: 1.0)
    let dependabilityColor = UIColor(red: 58/255.0, green: 74/255.0, blue: 146/255.0, alpha: 1.0)
    let enthusiasmColor = UIColor(red: 208/255.0, green: 62/255.0, blue: 37/255.0, alpha: 1.0)
    let optimismColor = UIColor(red: 131/255.0, green: 185/255.0, blue: 67/255.0, alpha: 1.0)
    
    var body: some View {
        ZStack{
            Color("Tidy")
            .ignoresSafeArea()
            .overlay(
        VStack {
            Text("New Chore")
                .font(Font.custom("Montserrat-SemiBold", size: 32, relativeTo: .title))
                .foregroundColor(Color("Harmony"))
                .padding(.top, 20)
            
            VStack {
                Form {
                    // Title
                    TextField("Chore Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .font(Font.custom("Monserrat-Regular",size:18))
                    
                    // Buttons above the category
                    VStack {
                        Stepper(value: $points, in: 0...100, step: 10) {
                            Text("Points: \(points)")
                                .font(Font.custom("Monserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                        }
                        Stepper(value: $penalty, in: 0...100, step: 10) {
                            Text("Penalty: \(penalty)")
                                .font(Font.custom("Monserrat-Regular",size:18))
                                .foregroundColor(Color("Serenity"))
                        }
                    }
                    
                    VStack {
                        Text("Category")
                            .font(Font.custom("Montserrat-SemiBold", size: 21))
                            .foregroundColor(Color("Serenity"))
                        
                        // Chore buttons
                        HStack(spacing: -55) {
                            CategoryButton(imageName: "Trash", caption: "Trash", selectedCategory: $selectedCategory)
                            CategoryButton(imageName: "Vacuum", caption: "Vacuum", selectedCategory: $selectedCategory)
                            CategoryButton(imageName: "Dishes", caption: "Dishes", selectedCategory: $selectedCategory)
                            CategoryButton(imageName: "Sweep", caption: "Sweep", selectedCategory: $selectedCategory)
                            CategoryButton(imageName: "Mop", caption: "Mop", selectedCategory: $selectedCategory)
                        }
                    }
                    
                    VStack {
                        Text("Assign Chore")
                            .font(Font.custom("Montserrat-SemiBold", size: 21))
                            .foregroundColor(Color("Serenity"))
                        
                        VStack {
                            HStack {
                                Toggle("Randomize", isOn: $randomIsToggled)
                                    .font(Font.custom("Monserrat-Regular",size:18))
                                    .foregroundColor(Color("Serenity"))
                                    .padding(.horizontal, 20.0)
                            }
                            
                            //                            HStack {
                            //                                MemberButton(imageName: "Trashw:Background")
                            //                                MemberButton(imageName: "Trashw:Background")
                            //                                MemberButton(imageName: "Trashw:Background")
                            //                            }
                            
                            HStack {
                                Toggle("Rotation", isOn: $rotateIsToggled)
                                    .font(Font.custom("Monserrat-Regular",size:18))
                                    .foregroundColor(Color("Serenity"))
                                    .padding(.horizontal, 20.0)
                            }
                        }
                    }
                    
                    // Due date
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .foregroundColor(Color("Serenity"))
                    
                    // Button
                    HStack {
                        Spacer()
                        CTButton(title: "Create", background: Color("Dependability")) {
                            if viewModel.canSave {
                                viewModel.save()
                                newItemPresented = false
                            } else {
                                viewModel.showAlert = true
                            }
                        }
                        .frame(width: 200)
                        Spacer()
                    }
                }
                .tint(Color("Dependability"))
                .background(Color("Tidy"))
                .scrollContentBackground(.hidden)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in a name and date and select a due date that is today or newer."))
                }
            }
        }
    )
    }
    }
}

struct CategoryButton: View {
    var imageName: String
    var caption: String
    @Binding var selectedCategory: String?
    let serenityColor = UIColor(red: 30/255.0, green: 37/255.0, blue: 71/255.0, alpha: 1.0)
    let dependabilityColor = UIColor(red: 58/255.0, green: 74/255.0, blue: 146/255.0, alpha: 1.0)
    
    var body: some View {
        let isSelected = selectedCategory == caption
        
        return VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .overlay(
                    Circle()
                        .strokeBorder(Color(dependabilityColor), lineWidth: 4)
                        .frame(width:60, height: 60)
                        .opacity(isSelected ? 1 : 0)
                )
                .onTapGesture {
                    selectedCategory = isSelected ? nil : caption
                }

            Text(caption)
                .font(.caption)
                .foregroundColor(Color(serenityColor))
        }
        .padding()
    }
}

struct MemberButton: View {
    var imageName:String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90, height: 90)
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
