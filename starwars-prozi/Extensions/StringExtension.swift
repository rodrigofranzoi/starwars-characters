//
//  StringExtension.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import Foundation
import UIKit

extension String {
    public func initials() -> String {
        let terms = components(separatedBy: " ")
        let firstInitial = terms.first?.first.map { "\($0)" } ?? ""
        let firstLastInitial = terms.first?.last.map { "\($0)" } ?? ""
        let lastInitial = terms.last?.first.map { "\($0)" } ?? ""
        return terms.count == 1 ? firstInitial + firstLastInitial : firstInitial + lastInitial
    }
    
    // define a color to a gender and a color to a skintone
    public var color: UIColor {
        switch self {
        case "male":
            return .systemBlue
        case "female":
            return .systemPink
        case "fair", "light":
            return .systemPink
        case "gold":
            return .yellow
        case "green":
            return .green
        case "white":
            return .white
        case "white, blue", "blue":
            return .blue
        case "white, red", "red":
            return .red
        default:
            return .systemGray4
        }
    }
}
