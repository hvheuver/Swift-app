//
//  Statistic.swift
//  swift-app
//
//  Created by Hendrik Van Heuverswyn on 31/12/2017.
//  Copyright © 2017 Hendrik Van Heuverswyn. All rights reserved.
//

import Foundation

class Statistic{
    var dataEntries: [DataEntry]
    
    init() {
        dataEntries = []
    }
    
    func appendData(data: DataEntry){
        dataEntries.append(data)
    }
}
