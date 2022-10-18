//
//  CommentaryService.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 13/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import Foundation

class CommentaryService {

   static let shared = CommentaryService()
 
   private init() {}

   private(set) var commentaries: [Commentary] = []

    func add(commentary: Commentary) {

      commentaries.append(commentary)

   }

}
