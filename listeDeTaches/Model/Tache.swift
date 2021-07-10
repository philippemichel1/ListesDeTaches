//
//  Tache.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 03/07/2021.
//

import Foundation
struct Tache: Identifiable, Codable {
    var id = UUID()
    var nom:String
    var statut:Bool
}
