//
//  md5.swift
//  ManualPrime
//
//  Created by Christopher Baus on 2/20/17.
//  Copyright © 2017 Chris Baus. All rights reserved.
//


import Foundation
func MD5(messageData: Data) -> Data? {
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
        }
    }
    
    return digestData
}

func MD5ToHex(data: Data) -> String {
    return dataToHex(data: data, size: UInt(CC_MD5_DIGEST_LENGTH))
}

func dataToHex(data: Data, size: UInt) -> String {
    var hex = ""
    for index in 0..<Int(size) {
        hex += String(format: "%02x", data[index])
    }

    return hex
}