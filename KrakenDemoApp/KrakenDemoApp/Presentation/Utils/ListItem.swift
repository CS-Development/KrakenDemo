//
//  ListItem.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation

struct ListItem<Key: Hashable , ValueObject: Hashable>: Hashable {
    let keyObject: Key
    let valueObject: ValueObject
}
