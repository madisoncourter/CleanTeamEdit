//
//  HeaderView.swift
//  CleanTeamTodo
//
//  Created by Yotam Ben-Bassat on 10/15/23.
//

/*import SwiftUI

struct HeaderView: View {
    

    let title: String
    let angle: Double
    let background: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            
            VStack {
                Text(title)
                    .font(Font.custom("MontserratAlternates-Medium", size: 50))
                    .foregroundColor(Color.white)
                    .bold()
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
        }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "CleanTeam", angle: 15, background: .blue)
    }
}*/

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle:String
    
    var body: some View {
        ZStack{
            Image("DownwardRoundedAccentDarkCropped")
                .offset(y:165)
            VStack (alignment:.leading){
                    Text(title)
                        .font(Font.custom("MontserratAlternates-SemiBold", size: 50))
                        .foregroundColor(Color("Harmony"))
                        //.bold()
                        .padding(.top,180)
                    Text(subtitle)
                        .font(Font.custom("Montserrat-SemiBold", size: 30))
                        .foregroundColor(Color("Serenity"))
                      // .foregroundColor(Color("Tidy"))

                }
                .padding(.top, 80)
                .padding(.trailing,80)
        }
       .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Subtitle")
    }
}
