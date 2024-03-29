//
//  OnboardingView.swift
//  CleanTeamEdit
//
//  Created by Madison  Courter on 12/7/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var pageIndex = 0
    @State private var isCreateModalPresented = false
    @State private var isJoinModalPresented = false
    @State private var groupName = ""
    @State private var groupId = ""
    
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    private let userId: String = "yourUserId"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Tidy")
                    .ignoresSafeArea()
                    .overlay(
                        TabView(selection: $pageIndex) {
                            ForEach(pages) { page in
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        if pageIndex != pages.count - 1 {
                                            Button("Skip", action: goToFive)
                                                .font(Font.custom("Montserrat-Medium", size: 18))
                                                .foregroundColor(Color("Serenity"))
                                                .padding(.horizontal, 20)
                                                .font(.title3)
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .padding()
                                    
                                    //Spacer()
                                    OnboardingPageView(page: page)
                                    Spacer()
                                    if page == pages.last {
                                        HStack {
                                            Button("Create", action: {
                                                isCreateModalPresented.toggle()
                                            })
                                            .padding(12)
                                            .padding(.horizontal,25)
                                            .font(Font.custom("Montserrat-Medium", size: 18))
                                            .foregroundColor(Color("Dependability"))
                                            .background(Color("Tidy"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(Color("Dependability"), lineWidth: 2)
                                            )
                                            .cornerRadius(30)
                                            .padding(.bottom,15)
                                            .padding(.horizontal,10)
                                            .sheet(isPresented: $isCreateModalPresented, content: {
                                                CreateGroupModal(isPresented: $isCreateModalPresented, groupName: $groupName)
                                            })
                                            
                                            Button("Join", action: {
                                                isJoinModalPresented.toggle()
                                            })
                                            .padding(12)
                                            .padding(.horizontal,40)
                                            .font(Font.custom("Montserrat-Medium", size: 18))
                                            .foregroundColor(.white)
                                            .background(Color("Dependability"))
                                            .cornerRadius(30)
                                            .padding(.bottom,15)
                                            .padding(.horizontal,10)
                                            .sheet(isPresented: $isJoinModalPresented, content: {
                                                JoinGroupModal(isPresented: $isJoinModalPresented, groupId: $groupId)
                                            })
                                        }
                                    } else {}
                                    
                                    Spacer(minLength: 60)
                                }
                                .tag(page.tag)
                            }
                        }
                        .animation(.easeInOut, value: pageIndex)
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .tabViewStyle(PageTabViewStyle())
                        .onAppear {
                            dotAppearance.currentPageIndicatorTintColor = UIColor(Color("Enthusiasm"))
                            dotAppearance.pageIndicatorTintColor = .gray
                        }
                    )
            }
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    
    func goToFive() {
        pageIndex = 5
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct CreateGroupModal: View {
    @Binding var isPresented: Bool
    @Binding var groupName: String
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Tidy")
                    .ignoresSafeArea()
                VStack{
                    TextField("Enter Group Name", text: $groupName)
                        .padding(.horizontal,15)
                        .padding(.bottom,-10)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Serenity"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:300, height:80)
                    
                    CTButton(title: "Create ", background: Color("Dependability")) {
                        // Implement Firebase logic to create the group with groupName
                        // Dismiss the modal
                        isPresented.toggle()
                    }
                    .frame(width:300, height:80)
                    .padding(.top,-10)
                    .font(Font.custom("Montserrat-Medium",size:15))

                }
                .padding()
                .background(Color("Tidy Darker"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                .navigationBarItems(leading:
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName:"arrow.left")
                         .foregroundColor(Color("Enthusiasm"))
                         .fontWeight(.bold)
                         .padding(.top,20)
                        })
                }

        }
    }
}

//Above code with fuction to show the group's id
/*import SwiftUI
 import Firebase // Add Firebase import if not already imported

 struct OnboardingView: View {
     @State private var pageIndex = 0
     @State private var isCreateModalPresented = false
     @State private var isJoinModalPresented = false
     @State private var groupName = ""
     @State private var groupId = ""
     
     private let pages: [Page] = Page.samplePages
     private let dotAppearance = UIPageControl.appearance()
     private let userId: String = "yourUserId"
     
     var body: some View {
         NavigationView {
             ZStack {
                 Color("Tidy")
                     .ignoresSafeArea()
                     .overlay(
                         TabView(selection: $pageIndex) {
                             ForEach(pages) { page in
                                 VStack {
                                     HStack {
                                         Spacer()
                                         
                                         if pageIndex != pages.count - 1 {
                                             Button("Skip", action: goToFive)
                                                 .font(Font.custom("Montserrat-Medium", size: 18))
                                                 .foregroundColor(Color("Serenity"))
                                                 .padding(.horizontal, 20)
                                                 .font(.title3)
                                         }
                                     }
                                     .foregroundColor(.black)
                                     .padding()
                                     
                                     //Spacer()
                                     OnboardingPageView(page: page)
                                     Spacer()
                                     if page == pages.last {
                                         HStack {
                                             Button("Create", action: {
                                                 isCreateModalPresented.toggle()
                                             })
                                             .padding(12)
                                             .padding(.horizontal,25)
                                             .font(Font.custom("Montserrat-Medium", size: 18))
                                             .foregroundColor(Color("Dependability"))
                                             .background(Color("Tidy"))
                                             .overlay(
                                                 RoundedRectangle(cornerRadius: 30)
                                                     .stroke(Color("Dependability"), lineWidth: 2)
                                             )
                                             .cornerRadius(30)
                                             .padding(.bottom,15)
                                             .padding(.horizontal,10)
                                             .sheet(isPresented: $isCreateModalPresented, content: {
                                                 CreateGroupModal(isPresented: $isCreateModalPresented, groupName: $groupName, groupId: $groupId)
                                             })
                                             
                                             Button("Join", action: {
                                                 isJoinModalPresented.toggle()
                                             })
                                             .padding(12)
                                             .padding(.horizontal,40)
                                             .font(Font.custom("Montserrat-Medium", size: 18))
                                             .foregroundColor(.white)
                                             .background(Color("Dependability"))
                                             .cornerRadius(30)
                                             .padding(.bottom,15)
                                             .padding(.horizontal,10)
                                             .sheet(isPresented: $isJoinModalPresented, content: {
                                                 JoinGroupModal(isPresented: $isJoinModalPresented, groupId: $groupId)
                                             })
                                         }
                                     } else {}
                                     
                                     Spacer(minLength: 60)
                                 }
                                 .tag(page.tag)
                             }
                         }
                         .animation(.easeInOut, value: pageIndex)
                         .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                         .tabViewStyle(PageTabViewStyle())
                         .onAppear {
                             dotAppearance.currentPageIndicatorTintColor = UIColor(Color("Enthusiasm"))
                             dotAppearance.pageIndicatorTintColor = .gray
                         }
                     )
             }
         }
     }
     
     func incrementPage() {
         pageIndex += 1
     }
     
     func goToZero() {
         pageIndex = 0
     }
     
     func goToFive() {
         pageIndex = 5
     }
 }

 struct OnboardingView_Previews: PreviewProvider {
     static var previews: some View {
         OnboardingView()
     }
 }

 struct CreateGroupModal: View {
     @Binding var isPresented: Bool
     @Binding var groupName: String
     @Binding var groupId: String // Add groupId binding
     
     var body: some View {
         NavigationView {
             ZStack {
                 Color("Tidy")
                     .ignoresSafeArea()
                 VStack {
                     TextField("Enter Group Name", text: $groupName)
                         .padding(.horizontal,15)
                         .padding(.bottom,-10)
                         .font(.system(size: 20))
                         .foregroundColor(Color("Serenity"))
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         .frame(width:300, height:80)
                     
                     CTButton(title: "Create ", background: Color("Dependability")) {
                         // Implement Firebase logic to create the group with groupName
                         // Retrieve the generated group ID
                         createGroup()
                         // Dismiss the modal
                         isPresented.toggle()
                     }
                     .frame(width:300, height:80)
                     .padding(.top,-10)
                     .font(Font.custom("Montserrat-Medium",size:15))
                 }
                 .padding()
                 .background(Color("Tidy Darker"))
                 .cornerRadius(16)
                 .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                 .navigationBarItems(leading:
                     Button(action: {
                         isPresented.toggle()
                     }) {
                         Image(systemName:"arrow.left")
                             .foregroundColor(Color("Enthusiasm"))
                             .fontWeight(.bold)
                             .padding(.top,20)
                     })
             }
         }
     }
     
     func createGroup() {
         // Implement Firebase logic to create the group with groupName
         // After successfully creating the group, set the groupId binding
         // For example, if you're using Firebase Realtime Database:
         let ref = Database.database().reference().child("groups").childByAutoId()
         ref.setValue(["name": groupName]) { (error, _) in
             if let error = error {
                 print("Error creating group: \(error.localizedDescription)")
             } else {
                 self.groupId = ref.key ?? "" // Update the groupId binding with the generated group ID
             }
         }
     }
 }
*/

struct JoinGroupModal: View {
    @Binding var isPresented: Bool
    @Binding var groupId: String
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Tidy")
                    .ignoresSafeArea()
                VStack {
                    TextField("Enter Group ID", text: $groupId)
                        .padding(.horizontal,15)
                        .padding(.bottom,-10)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Serenity"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:300, height:80)
                    CTButton(title: "Join ", background: Color("Dependability")) {
                        // Implement Firebase logic to join the group with groupId
                        // Dismiss the modal
                        isPresented.toggle()
                    }
                    .frame(width:300, height:80)
                    .padding(.top,-10)
                    .font(Font.custom("Montserrat-Medium",size:15))
                }
                .padding()
                .background(Color("Tidy Darker"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                .navigationBarItems(leading:
                    Button(action: {
                        isPresented.toggle()
                    }) {
                    Image(systemName:"arrow.left")
                        .foregroundColor(Color("Enthusiasm"))
                        .fontWeight(.bold)
                        .padding(.top,20)
                    })
            }
        }
    }
}


/*import SwiftUI

struct OnboardingView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    private let userId: String = "yourUserId"
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Tidy")
                .ignoresSafeArea()
                .overlay(
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        HStack{
                            Spacer()
                            
                            if pageIndex != pages.count - 1 {
                                Button("Skip", action: goToFive)
                                    .font(Font.custom("Montserrat-Medium", size: 18))
                                    .foregroundColor(Color("Serenity"))
                                    .padding(.horizontal, 20)
                                    .font(.title3)
                            }
                        }
                        .foregroundColor(.black)
                        .padding()
                        
                        //Spacer()
                        OnboardingPageView(page: page)
                        Spacer()
                        if page == pages.last {
                            HStack{
                                NavigationLink(destination: TodoListView(userId: self.userId)) {
                                    Text("Create")
                                        .padding(12)
                                        .padding(.horizontal,30)
                                        .font(Font.custom("Montserrat-Medium", size: 18))
                                        .foregroundColor(Color("Dependability"))
                                        .background(Color("Tidy"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color("Dependability"), lineWidth: 2)
                                            )
                                        .cornerRadius(30)
                                        .padding(.bottom,15)
                                }
                                .padding(.horizontal, 5)
                                NavigationLink(destination: TodoListView(userId: self.userId)) {
                                    Text("Join")
                                        .padding(12)
                                        .padding(.horizontal,40)
                                        .font(Font.custom("Montserrat-Medium", size: 18))
                                        .foregroundColor(.white)
                                        .background(Color("Dependability"))
                                        .cornerRadius(30)
                                        .padding(.bottom,15)
                                }
                                .padding(.horizontal, 5)

                                
                            }
                            
                        } else{}
                        
                        Spacer(minLength: 60)
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)// 2
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = UIColor(Color("Enthusiasm"))
                dotAppearance.pageIndicatorTintColor = .gray
            }
            )
        }
    }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    
    func goToFive() {
        pageIndex = 5
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}*/
