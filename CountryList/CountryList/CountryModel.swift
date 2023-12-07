//
//  CountryModel.swift
//  CountryList
//
//  Created by DMonaghan on 12/2/23.
//

import Foundation

struct Country: Codable {
    let name: String
    let region: String
    let code: String
    let capital: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, code, capital
    }
}
