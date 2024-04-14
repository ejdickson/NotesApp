//
//  NoteModel.swift
//  Notes
//
//  Created by Emma Brennan on 4/14/24.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
