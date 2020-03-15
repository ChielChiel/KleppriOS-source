//
//  ContentView.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 08/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import SwiftUI
import Combine
// https://kleppr.herokuapp.com/api/v1?code=5xasd87b



struct ContentView: View {
    
    let gradient = LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    @State var animate = false
    //310 = top 0 = normaal
    @State private var relPos: CGFloat = .zero
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.offWhite
            
            ZStack {
                IdCard()

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
                .padding(.top, 20)
                .layoutPriority(20)
            }
            //Subscribe()
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.offWhite)
                    .frame(width: 375, height: 630, alignment: .center)
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .edgesIgnoringSafeArea(.all)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .offset(x: 0, y: (120 - self.relPos))
//                Text("Hello")
//                    .foregroundColor(Color.black)
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
                if trans > 220 {
                    self.relPos = 310
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


struct Subscribe: View {
    @ObservedObject var fetcher = NetworkingManager()
    
    var body: some View {
        ZStack {
            Color.offWhite
            List {
                ForEach(fetcher.bedrijfLijst, id: \.self) { bedrijfList in
                    ListItems(company: bedrijfList.company, sub: bedrijfList.sub)
                        
                }
                
            }
            .onAppear {
                UITableView.appearance().separatorColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                UITableView.appearance().backgroundColor = .clear
            }
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

        }
        
    }
}

    struct ListItems: View {
        @State var company: String
        @State var sub: String

        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.offWhite)
                    .frame(width: 340, height: 70, alignment: .leading)
                    .shadow(color: .gray, radius: 20, x: 5, y: 5)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
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
                        Text(self.company)
                            .font(.headline)
                        Text(self.sub)
                            .font(.subheadline)
                    }
                    
                }.edgesIgnoringSafeArea(.all)
                .padding(.leading, 10.0)
            }

        }
    }
    
struct IdCard: View {
    var body: some View {
        ZStack{
            //Color.offWhite
            Rectangle()
                .fill(Color.offWhite)
                .frame(width: 330, height: 260, alignment: .center)
                .shadow(color: .gray, radius: 20, x: 5, y: 5)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            Text("5xasd87b")
                .font(.system(size: 50, weight: .light, design: .default))
                .fontWeight(.light)
                .foregroundColor(.black)
        }
        .padding(.top, 280)
    }
}


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
        .padding(30)
        .background(
            Circle()
                .fill(Color.offWhite)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                //.cornerRadius(30, corners: [.topLeft, .bottomLeft])
        )
    }
}


//class FetchCompanies: ObservableObject {
//  // 1.
//  @Published var companies = [Bedrijf]()
//
//    init() {
//        let url = URL(string: "https://kleppr.herokuapp.com/api/v1?code=5xasd87b")!
//        // 2.
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            do {
//                if let todoData = data {
//                    // 3.
//                    let decodedData = try JSONDecoder().decode([Bedrijf].self, from: todoData)
//                    DispatchQueue.main.async {
//                        self.companies = decodedData
//                    }
//                } else {
//                    print("No data")
//                }
//            } catch {
//                print("Error")
//            }
//        }.resume()
//    }
//}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
