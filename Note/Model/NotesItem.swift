//
//  NotesItem.swift
//  Note
//
//  Created by anca dev on 01/05/23.
//

import Foundation

class NotesItem: Encodable, Decodable {
    var title: String = ""
    var text: String = ""
    var delete: Bool = false
}
