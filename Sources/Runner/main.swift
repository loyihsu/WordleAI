//
//  main.swift
//  WordleAI
//
//  Created by Loyi Hsu on 2022/1/20.
//

import WordleAI
import Foundation

let knowledge: [Knowledge] = [ ]

if let found = find(with: knowledge) {
    print(found)
} else {
    print("No choice to be made.")
}

