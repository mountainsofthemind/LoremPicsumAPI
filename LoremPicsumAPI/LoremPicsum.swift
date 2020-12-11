//
//  LoremPicsum.swift
//  LoremPicsumAPI
//
//  Created by Field Employee on 12/10/20.
//

import Foundation

struct LoremPicsum: Decodable {
  let id: String
  let download_url: URL
  
  enum CodingKeys: String, CodingKey {
    case id
    case download_url
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.download_url = try container.decode(URL.self, forKey: .download_url)
  }
}
