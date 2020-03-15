//
//  Fetch.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 13/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import Foundation
import SwiftUI
import Combine



public class NetworkingManager: ObservableObject {
    public struct BedrijfList: Decodable, Identifiable, Hashable {
        public var id: Int
        public var company: String
        public var sub: String
    }
    
    
    @Published var bedrijfLijst = [BedrijfList]()
    init() {
       print("call")
        // guard let url = URL(string: "https://kleppr.herokuapp.com/api/v1?code=5xasd87b") else { return }
        guard let url = URL(string: "https://kleppr.herokuapp.com/api/v1?code=5xasd87b") else { return }
        
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([BedrijfList].self, from: d)
                    DispatchQueue.main.async {
                        self.bedrijfLijst = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
    }
}
