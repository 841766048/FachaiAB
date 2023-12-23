//
//  Toast.swift
//  FachaiAB
//
//  Created by   on 2023/11/20.
//

import Foundation
import Loaf


func toast(_ message: String, state: Loaf.State) {
    if let vc = topViewController() {
        Loaf(message, state: state, sender: vc).show()
    }
}
