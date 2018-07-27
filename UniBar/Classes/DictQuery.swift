//
//  DictQuery.swift
//  UniBar
//
//  Created by David Chen on 7/27/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Foundation

fileprivate func runDictQueryScript(dictionaryPath: String, pattern: String) -> String? {
    guard let scriptPath = Bundle.main.path(forResource: "mdictquery/dictquery", ofType: "py") else {
        return nil
    }
    
    var arguments = [scriptPath]
    arguments.append(dictionaryPath)
    arguments.append("wildcard")
    arguments.append(pattern)
    
    let outPipe = Pipe()
    let errPipe = Pipe();
    
    let task = Process()
    task.launchPath = "/usr/bin/python"
    task.arguments = arguments
    task.standardInput = Pipe()
    task.standardOutput = outPipe
    task.standardError = errPipe
    task.launch()
    //print(arguments)
    
    let data = outPipe.fileHandleForReading.readDataToEndOfFile()
    task.waitUntilExit()
    
    let exitCode = task.terminationStatus
    if (exitCode != 0) {
        print(String(data: data, encoding: String.Encoding.ascii))
        print("ERROR: \(exitCode)")
        return nil
    }
    
    return String(data: data, encoding: String.Encoding.ascii)
}

func dictQuery (pattern: String) -> [String: String]? {
    if let jsonString = runDictQueryScript(dictionaryPath: "", pattern: pattern) {
        //print(jsonString)
        do {
            if let dataFromString = jsonString.data(using: .ascii) {
                print(dataFromString)
                print(jsonString )
                let jsondata = try JSON(data: dataFromString)
                print(jsondata)
                var result: [String: String] = [:]
                for (key, def): (String, JSON) in jsondata {
                    print(key)
                    print(def)
                    result[key] = def.stringValue
                }
                return result
            }
        } catch let e {
            print(e)
        }
    }
    return nil
}
