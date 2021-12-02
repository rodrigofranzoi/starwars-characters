//
//  StringExtension.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import Foundation

extension String {
    public func initials() -> String {
        let terms = components(separatedBy: " ")
        let firstInitial = terms.first?.first.map { "\($0)" } ?? ""
        let firstLastInitial = terms.first?.last.map { "\($0)" } ?? ""
        let lastInitial = terms.last?.first.map { "\($0)" } ?? ""
        return terms.count == 1 ? firstInitial + firstLastInitial : firstInitial + lastInitial
    }
}
