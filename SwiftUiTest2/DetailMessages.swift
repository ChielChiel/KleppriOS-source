//
//  DetailMessages.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 15/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import SwiftUI
import WebKit

struct DetailMessages: View {
    var bedrijf: NetworkingManager.BedrijfList
    var body: some View {
        ZStack(alignment: .top) {
            Color.offWhite
            VStack(alignment: .center) {
                CompanyCard(name: bedrijf.company, sub: bedrijf.sub)
                    .padding(.horizontal)
                    .padding(.top, -200)
                EnWebView(width: 330, height: 330, html: "<h2>hallo<h2><br><p>boi</p><ul><li>Coffee</li><li>Tea</li><li>Milk</li></ul>")
            }
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
            NMCard(width: 330, height: 180)
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
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            Text(self.sub)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            }
        .padding(.top, 280)
    }
}

struct NMCard: View {
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.offWhite)
            .frame(width: self.width, height: self.height, alignment: .center)
            .shadow(color: .gray, radius: 20, x: 5, y: 5)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct EnWebView: View {
    @State var width: CGFloat
    @State var height: CGFloat
    @State var html: String
    var fontCus = Font.system(.body, design: .default)
    
    var body: some View {
        ZStack {
            NMCard(width: width, height: height)
            WebView(html: "<head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background: rgb(225,225,235) !important; font-family: Helvetica; '>\(html)</body>")
                .padding(.all, 30)
                .frame(width: self.width, height: self.height)
            

        }.padding()
        
    }
}

struct WebView: UIViewRepresentable {
    @State var html: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }

    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {
        view.loadHTMLString(html, baseURL: nil)
    }
}


struct DetailMessages_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailMessages(bedrijf: NetworkingManager.BedrijfList(id: 1, company: "Michiel Schouten Enzone", sub: "Ah yes, enslaved water", detail:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum nulla enim, et finibus neque venenatis sit amet. Aenean fringilla mattis nisl, id eleifend diam efficitur aliquam. Cras consequat neque et molestie pellentesque. Fusce ultricies, elit nec lacinia fermentum, elit tellus commodo leo, eu elementum magna libero quis metus. Nam.", send: "16/03 12:12"))
    }
}
