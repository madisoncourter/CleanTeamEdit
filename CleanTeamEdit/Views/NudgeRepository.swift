//
//  NudgeRepository.swift
//  Nudge Messaging
//
//  Created by Madison  Courter on 11/30/23.
//
import SwiftUI

enum NudgeViewType {
    case inbox
    case outbox
}

struct NudgeRepository: View {
    @StateObject private var viewModel = NudgeRepositoryModel()
    @State private var searchText = ""
    @State private var selectedView: NudgeViewType = .inbox // Default view is inbox
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(named: "Tidy")

        // Set large title text attributes
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "Harmony") ?? .purple,
            .font: UIFont(name: "MontserratAlternates-SemiBold", size: 35)!
        ]

        // Set title text attributes
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Harmony") ?? .purple,
            .font: UIFont(name: "MontserratAlternates-SemiBold", size: 20)!
        ]

        // Set back button color
        UINavigationBar.appearance().tintColor = UIColor(named: "Enthusiasm") ?? .purple

        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.clear]


        // Set standard, scrollEdge, and compact appearances
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        /*UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance*/
        UINavigationBar.appearance().compactAppearance = navBarAppearance

        // Set back button color
            UIBarButtonItem.appearance().tintColor = UIColor(named: "Enthusiasm") ?? .orange

            // Set back button image
            let arrowImage = UIImage(systemName: "arrow.left")
            navBarAppearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
    }


    var body: some View {
        NavigationView {
            ZStack {
                Color("Tidy")
                    .ignoresSafeArea()
                Image("UpwardRoundedAccentDarkCropped")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(width:350, height:350)
                    .offset(x:-20,y:180)
                    .opacity(0.5)
                    .colorMultiply(Color("Tidy")) // Set the tint color
                VStack {
                    Picker("Select View", selection: $selectedView) {
                        Text("Inbox").tag(NudgeViewType.inbox)
                        Text("Sent").tag(NudgeViewType.outbox)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    SearchBar(text: $searchText)

                    List {
                        ForEach(viewModel.filteredNudges(searchText: searchText)) { nudge in
                            NavigationLink(destination: NudgeDetailView(nudge: nudge)) {
                                HStack {
                                    Circle()
                                        .fill(Color("Tidy Darker"))
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Image("DisappointedTerryFlipped")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.white)
                                        )
                                        .padding(.trailing, 8)

                                    VStack(alignment: .leading) {
                                        Text(nudge.message)
                                        Text("Received on \(formattedDate(from: nudge.date))")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .listRowBackground(Color("Tidy"))
                            .listRowSeparatorTint(Color("Enthusiasm"))
                        }
                        .onDelete { indexSet in
                            viewModel.removeNudges(at: indexSet)
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationBarTitle(selectedView == .inbox ? "Nudge Inbox" : "Sent Nudges")
                .navigationBarItems(trailing: NavigationLink(destination: NudgeCreationView(), label: {
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 23, height:23)
                        .foregroundColor(Color("Enthusiasm"))
                        .fontWeight(.bold)
                        .padding()
                }))
                
            }
        }
    }

    func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct NudgeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NudgeRepository()
    }
}

struct Nudge: Identifiable {
    var id = UUID()
    var message: String
    var date: Date
    // Add more properties as needed
}

class NudgeRepositoryModel: ObservableObject {
    @Published var nudges: [Nudge] = [
        Nudge(message: "The dishes aren't going to wash themselves.", date: Date()),
        Nudge(message: "Trash duty is calling!", date:
                Date().addingTimeInterval(-3600)),
        // Add more nudges
    ]

    func filteredNudges(searchText: String) -> [Nudge] {
        guard !searchText.isEmpty else {
            return nudges
        }

        return nudges.filter { nudge in
            nudge.message.lowercased().contains(searchText.lowercased())
        }
    }

    func removeNudges(at offsets: IndexSet) {
            nudges.remove(atOffsets: offsets)
        }
}

struct NudgeDetailView: View {
    var nudge: Nudge
    var body: some View {
        ZStack{
            Color("Tidy")
            .ignoresSafeArea()
        VStack{
            Text(nudge.message)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                        //.shadow(radius: 3)
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: .infinity)
                )
                .offset(x:-50,y:40)
                .padding()
            Image("DisappointedTerry")// Change to Dissapointed Terry
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .offset(x:70,y:50)
            
            Spacer()
            
           VStack {
               VStack{
                   CTButton(title: "Mark as Complete", background: Color("Dependability")) {
                       
                   }
                   .frame(width:300, height:80)
               }
               .font(Font.custom("Montserrat-Medium",size:15))
               .padding(.bottom,-10)
               
              //  Spacer()
                
                Button(action: {
                        // Handle deletion
                    }) {
                        Text("Delete")
                        .font(Font.custom("Montserrat-SemiBold",size:17))
                        .padding(.horizontal,100)
                        .padding(.vertical,10)
                        .foregroundColor(Color("Serenity"))
                        .background(RoundedRectangle(cornerRadius: 50).fill(Color("Tidy")))
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("Serenity"), lineWidth: 2))
                }
            }
            .font(Font.custom("Montserrat-Medium",size:15))
            .padding(.horizontal)
            .padding(.bottom,30)
        }
        .padding(.top, 20)
    }
    .navigationTitle("Your Message")
        
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color("Tidy Darker"))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
