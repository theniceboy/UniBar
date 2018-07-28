//
//  ShellCommand.swift
//  UniBar
//
//  Created by David Chen on 7/28/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Foundation

extension String {
    func run() -> String? {
        let pipe = Pipe()
        let process = Process()
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", self]
        process.standardOutput = pipe
        
        let fileHandle = pipe.fileHandleForReading
        process.launch()
        
        return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
    }
}
