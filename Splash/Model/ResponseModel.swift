//
//  ResponseModel.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//

import Foundation

struct ResponseModel: Codable {
    var id = ""
    var author = ""
    var width = 0
    var height = 0
    var url = ""
    var downloadUrl = ""
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadUrl = "download_url"
    }
}

