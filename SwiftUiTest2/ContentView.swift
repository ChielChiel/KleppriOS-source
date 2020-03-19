//
//  ContentView.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 08/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import SwiftUI
import Combine
import NotificationCenter
// https://kleppr.herokuapp.com/api/v1?code=5xasd87b


//MARK: ContentView
struct ContentView: View {
    @State var animate = false
    //310 = top 0 = normaal
    @State private var relPos: CGFloat = .zero
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Color.offWhite
                
                ZStack {
                    IdCard(code: "5xasd87b")
                    
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            print("Button tapped")
//                        }) {
//                            Image(systemName: "heart.fill")
//                                .foregroundColor(.gray)
//                        }
//                        .buttonStyle(SimpleButtonStyle())
//                    }
//                    .padding(20)
//                    .layoutPriority(20)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        print("Button tapped")
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(SimpleButtonStyle())
                }
                .padding(20)
                
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.offWhite)
                        .frame(width: 375, height: 630, alignment: .center)
                        .cornerRadius(40, corners: [.topLeft, .topRight])
                        .edgesIgnoringSafeArea(.all)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        .offset(x: 0, y: (120 - self.relPos))
                    
                    Subscribe()
                        .offset(x: 0, y: (190 - self.relPos))
                }
                .gesture(DragGesture()
                .onChanged({ (waarde) in
                    let trans = -1 * waarde.translation.height
                    if !(trans > 9 && trans < 12) && !(trans > -15 && trans < 0) {
                        self.relPos = trans
                    }
                    
                    print(trans)
                })
                    
                    .onEnded({ (waarde) in
                        let trans = -1 * waarde.translation.height
                        if trans >= 220 {
                            self.relPos = 250
                        }
                        if trans < 220 {
                            self.relPos = 0
                        }
                    })
                    
                ).animation(.spring())
                    
                    .position(x: 187, y: 550)
                    //.padding(.top, 250)
                    .layoutPriority(40)
            }
                
            .background(Color.offWhite)
            .edgesIgnoringSafeArea(.top)
            
        }
    
    }
}

//MARK: Subscribe
struct Subscribe: View {
    @ObservedObject var fetcher = NetworkingManager()
    @State private var action: Int? = 0
    
    
    var body: some View {
        ZStack {
            Color.offWhite
            List {
                ForEach(fetcher.bedrijfLijst, id: \.self) { bedrijfList in
                    ListItems(bedrijfFull: bedrijfList)
                }
            }
        
            .onAppear {
                UITableView.appearance().separatorColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().selectionStyle = .none
            }
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            
        }
    }
}

//MARK: ListItems
struct ListItems: View {
    @State var bedrijfFull: NetworkingManager.BedrijfList
    @State private var action: Int?
    @State private var isLongPress: Bool = false
    @State private var afzet: CGFloat = .zero
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                //NavigationLink(destination: DetailMessages(bedrijf: bedrijfFull)) {
                NavigationLink(destination: DetailMessages(bedrijf: bedrijfFull), tag: 1, selection: $action) {
                    EmptyView()
                }
                Rectangle()
                    .fill(Color.offWhite)
                    .frame(width: 340, height: 70, alignment: .leading)
                    .shadow(color: .gray, radius: 20, x: 5, y: 5)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .onTapGesture {
                        self.action = 1
                }
                HStack() {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: 47, height: 47, alignment: .leading)
                            .shadow(color: .gray, radius: 20, x: 5, y: 5)
                            .cornerRadius(10)
                        Image(systemName: "book.fill")
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text(self.bedrijfFull.company)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(self.bedrijfFull.sub)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    
                }.edgesIgnoringSafeArea(.all)
                    .padding(.leading, 10.0)
            }
            .offset(x: 8 * self.afzet, y: .zero)
            .onLongPressGesture(minimumDuration: 1.4,pressing: { (drukken) in
                self.isLongPress = drukken
            }) {
            }
            
            if self.isLongPress {
                Text(self.bedrijfFull.send)
                    .foregroundColor(.black)
                    .onAppear {
                        self.afzet = -10
                    }
                .onDisappear {
                    self.afzet = .zero
                }
                .offset(x: 1 * self.afzet, y: .zero)
                .padding(.leading, -75)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .animation(.spring())
                    
                
            }
            
        }
    }
}

//MARK: IdCard
struct IdCard: View {
    @State var code: String
    @State private var isLongPress: Bool = false
    @State private var afzet: CGFloat = .zero
    
    var body: some View {
       VStack {
            ZStack{
                //Color.offWhite
                Rectangle()
                    .fill(Color.offWhite)
                    .frame(width: 330, height: 260, alignment: .center)
                    .shadow(color: .gray, radius: 20, x: 5, y: 5)
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                Text(self.code)
                    .font(.system(size: 50, weight: .light, design: .default))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                }
            .animation(.spring())
            .padding(.top, 50)
            .onLongPressGesture(minimumDuration: 1.4,pressing: { (drukken) in
                self.isLongPress = drukken
                if self.isLongPress {
                        // Enable string-related control...
                        UIPasteboard.general.string = self.code
                }
            }) {
                
            }
            if self.isLongPress {
                Text("Copied")
                    .onAppear {
                        self.afzet = 10
                    }
                .onDisappear {
                    self.afzet = .zero
                }
                .offset(x: 0, y: self.afzet)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .animation(.spring())
                    
                
            }
        }.onAppear {
            print("appear")
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "copy-code-noti"), object: nil, queue: .main) { (Noti) in
                print("kopie")
                let kopie = Noti.userInfo?["copy"] as? Bool

                self.isLongPress = kopie ?? false
                if self.isLongPress {
                        // Enable string-related control...
                        UIPasteboard.general.string = self.code
                }
                
                
            }
        }
    }
}

//MARK: Extensions
extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

extension UIColor {
    static let offWhite = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                Circle()
                    .fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        )
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
