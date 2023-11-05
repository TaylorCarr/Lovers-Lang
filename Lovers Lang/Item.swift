//
//  Item.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 11/4/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
