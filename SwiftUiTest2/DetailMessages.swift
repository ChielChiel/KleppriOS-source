//
//  DetailMessages.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 15/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import SwiftUI

struct DetailMessages: View {
    var bedrijf: NetworkingManager.BedrijfList
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.offWhite
            CompanyCard(name: bedrijf.company, sub: bedrijf.sub)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CompanyCard: View {
    @State var name: String
    @State var sub: String
    
    var body: some View {
        ZStack{
            //Color.offWhite
            Rectangle()
                .fill(Color.offWhite)
                .frame(width: 330, height: 180, alignment: .center)
                .shadow(color: .gray, radius: 20, x: 5, y: 5)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            VStack{
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 47, height: 47, alignment: .leading)
                        .shadow(color: .gray, radius: 20, x: 5, y: 5)
                        .cornerRadius(10)
                    Image(systemName: "book.fill")
                    
                }
            Text(self.name)
                .font(.system(size: 50, weight: .light, design: .default))
                .fontWeight(.light)
                .foregroundColor(.black)
            Text(self.sub)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.black)
        
            }
            }
        .padding(.top, 280)
    }
}

struct DetailMessages_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailMessages(bedrijf: NetworkingManager.BedrijfList(id: 1, company: "Michiel", sub: "Ah yes, enslaved water", detail:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum nulla enim, et finibus neque venenatis sit amet. Aenean fringilla mattis nisl, id eleifend diam efficitur aliquam. Cras consequat neque et molestie pellentesque. Fusce ultricies, elit nec lacinia fermentum, elit tellus commodo leo, eu elementum magna libero quis metus. Nam.", send: "16/03 12:12"))
    }
}
