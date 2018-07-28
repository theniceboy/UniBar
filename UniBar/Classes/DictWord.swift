//
//  DictWord.swift
//  UniBar
//
//  Created by David Chen on 7/27/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Foundation

class DictWord {
    var term: String = ""
    var def: [String] = []
    var plain: String = ""
    
    init(word: String, definition: String) {
        term = word
        def.append(definition)
        plain = definition.html2String.trimmingCharacters(in: .whitespacesAndNewlines)
        plain = plain.replacingOccurrences(of: "\n", with: " ")
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
