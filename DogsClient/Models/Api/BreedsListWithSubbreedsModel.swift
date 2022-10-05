//
//  BreedsList.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import Foundation

struct BreedsListWithSubbreedsModel: Codable {
  let status: String
  let contents: [String:[String]]
  
  private enum CodingKeys: String, CodingKey {
    case status
    case contents = "message"
  }
}
