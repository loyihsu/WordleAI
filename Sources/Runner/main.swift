/**
 # Runner (WordleAI)
 Created by Yu-Sung Loyi Hsu on 2022/1/20
 */

import WordleAI

let finder = Finder()

let knowledge: [Knowledge] = [ ]

if let found = finder.findOne(with: knowledge) {
    print(found)
} else {
    print("No choice to be made.")
}
