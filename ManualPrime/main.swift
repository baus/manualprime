//
//  main.swift
//  ManualPrime
//
//  Created by Christopher Baus on 2/5/17.
//  Copyright (c) 2017 Chris Baus. All rights reserved.
//

import Foundation




let baseDirectory = "/Users/baus/Dropbox/images/ssddump/"
let fileManager = FileManager.default
let filesEnumerator = fileManager.enumerator(atPath: baseDirectory)
var filesizeDict = [UInt64:[String]]()


do {
    while let element = filesEnumerator?.nextObject() as? String {
        var path = "\(baseDirectory)\(element)"
        var isDir : ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) as Bool {
            if isDir.boolValue {
                continue
            }
        }
        else {
            continue
        }
        let attr = try FileManager.default.attributesOfItem(atPath: path)

        let fileSize = attr[FileAttributeKey.size] as! UInt64
        if filesizeDict[fileSize] == nil {
            filesizeDict[fileSize] = ["\(baseDirectory)\(element)"]
        }
        else {
            filesizeDict[fileSize]!.append("\(baseDirectory)\(element)")
        }

        print("\(baseDirectory)\(element)")

        try Data(contentsOf: URL(fileURLWithPath: "\(baseDirectory)\(element)"))

        try MD5(messageData: Data(contentsOf: URL(fileURLWithPath: "\(baseDirectory)\(element)")))

        // try print(MD5ToHex(data: MD5(messageData: Data(contentsOf: URL(fileURLWithPath: "\(baseDirectory)\(element)")))! as Data))
    }
    for (key, value) in filesizeDict {
        let size = value.count
        print("\(key) size: \(size)")
    }

} catch {
    print("Error: \(error)")
}
