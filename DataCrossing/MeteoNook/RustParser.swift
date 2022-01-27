//
//  RustParser.swift
//  DataCrossing
//
//  Created by Natalie on 11/22/21.
//

import Foundation

class RustParser {
    func parse(to: String) -> String {
        let result = rust_parse(to)
        let swift_result = String(cString: result!)
        rust_parse_free(UnsafeMutablePointer(mutating: result))
        return swift_result
    }
}
