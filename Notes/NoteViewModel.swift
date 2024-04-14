//
//  NoteViewModel.swift
//  Notes
//
//  Created by Emma Brennan on 4/14/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


class NoteViewModel : ObservableObject {
    
    @Published var notes = [NoteModel]()
    let db = Firestore.firestore()
    
    func fetchData() {
        self.notes.removeAll()
        db.collection("notes")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.notes.append(try document.data(as: NoteModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
        }
    }
    
    func saveData(note: NoteModel) {
        
        if let id = note.id {
            // Edit existing note by ID without deleting note entirely
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                let docRef = db.collection("notes").document(id)
                
                docRef.updateData([
                    "title": note.title,
                    "notesdata": note.notesdata
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            // Create new note with protection against blank/empty notes
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("notes").addDocument(data: [
                    "title": note.title,
                    "notesdata": note.notesdata
                  ]) { err in
                      if let err = err {
                          print("Error adding document: \(err)")
                      } else {
                          print("Document added with ID: \(ref!.documentID)")
                      }
                  }
            }
            
        }
    }
}
