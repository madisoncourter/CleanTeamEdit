//
//  TodoListItemView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

import SwiftUI

struct TodoListItemView: View {
    
    @StateObject var viewModel = TodoListItemViewViewModel()
    
    let item: ToDoListItem
    
    var body: some View {
            HStack{
                Button {
                    viewModel.toggleIsDone(item: item)
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(Color.green)
                        .frame(width:50)
                }
                .padding(.horizontal,-15)

                VStack(alignment: .leading){
                    Text(item.title)
                        .font(.body)
                    Text("Due \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(Color(.secondaryLabel))
                }
                
                Spacer()
                
                Menu {
                    Button{
                        
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button{
                        
                    } label: {
                        Label("Send Nudge", systemImage: "arrowshape.turn.up.right")
                    }
                    Button (role:.destructive){
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .rotationEffect(.degrees(90))

                /*Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                */

            }
    }
}

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(item: .init(
            id: "123",
            title: "Milk",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: true))
    }
}
