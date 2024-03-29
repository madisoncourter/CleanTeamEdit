//
//  OnboardingPageView.swift
//  CleanTeamEdit
//
//  Created by Madison  Courter on 12/7/23.
//

import SwiftUI

struct OnboardingPageView: View {
    var page: Page
    var body: some View {
        ZStack{
            Color("Tidy")
            .ignoresSafeArea()
            .overlay(
        VStack() {
            Image("\(page.image)")
                .resizable()
                .scaledToFit()
                .padding()
                .cornerRadius(30)
            //.background(.gray.opacity(0.10))
                .cornerRadius(10)
                .padding()
            
            Text(page.name)
                .font(Font.custom("MontserratAlternates-Medium", size: 32, relativeTo: .title))
            // .fontWeight(.bold)
                .foregroundColor(Color("Harmony"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
            Text(page.description)
                .font(Font.custom("Montserrat-Medium", size: 18))
                .foregroundColor(Color("Serenity"))
                .padding(.top,10)
                .padding(.horizontal, 15)
                .frame(width: 350)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
            
            Spacer()
        }
        )
    }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: Page.samplePage)
    }
}
