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

struct AllMessages: Codable {
    var messages: [Message]
}

struct Message: Codable, Hashable {
    var id: Int
    var company: String
    var sub: String
    var detail: String
    var send: String
}
