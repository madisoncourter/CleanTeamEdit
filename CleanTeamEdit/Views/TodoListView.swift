//
//  TodoListItemsView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct TodoListView: View {
    @StateObject var viewModel: TodoListViewViewModel
    
    @FirestoreQuery var items: [ToDoListItem]
    
    //Navigation Title Color and Font
    /*init() {
        // Set custom font for large title text in the navigation bar
        if let customFont = UIFont(name: "MontserratAlternates-SemiBold", size: 34.0) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor(named: "Harmony") ?? .purple,
                .font: customFont
            ]
        }
    }*/
    
    
    init (userId: String) {
        //users/<id>/todos/<entries>
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: TodoListViewViewModel(userId: userId)
        )
    }

    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Tidy")
                .ignoresSafeArea()
                .overlay(
                VStack{
                    HStack{
                        Text("Your Chores")
                            .font(Font.custom("Montserrat-SemiBold", size: 25, relativeTo: .title))
                        //.fontWeight(.bold)
                            .foregroundColor(Color("Serenity"))
                            .padding(.top, 10)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    VStack {
                        
                        List(items) { item in
                            TodoListItemView(item: item)
                                .swipeActions {
                                    Button("Delete") {
                                        viewModel.delete(id: item.id)
                                    }
                                    .tint(.red)
                                    
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(radius: 3))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("To-Do List")
                .toolbar {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 25, height:25)
                            .foregroundColor(Color("Enthusiasm"))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                }
                .sheet(isPresented: $viewModel.showingNewItemView) {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                }
                )
            }
        }
    }
}

struct TodoListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(userId: "DlOTGH6rHQcpvVqhRnAgavxEYwi2")
    }
}
