import Foundation
import CoreData
import UIKit

class NotesStore {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes: [Note]
    
    init() {
        notes = []
        loadNotes()
    }
    
    func append(text: String) {
        let note = Note(context: context)
        note.text = text
        note.id = UUID().uuidString
        note.dateCreating = Date().timeIntervalSince1970
        while notes.contains(where: { $0.id == note.id }) {
            note.id = UUID().uuidString
        }
        notes.append(note)
        saveNotes()
    }
    
    func remove(_ note: Note) {
        guard let index = notes.firstIndex(of: note) else { return }
        context.delete(notes[index])
        notes.remove(at: index)
        saveNotes()
    }
    
    func replaceNote(_ note: Note) {
        guard notes.contains(where: { $0.id == note.id }) else { return }
        for i in notes.indices {
            if notes[i].id == note.id {
                let newNote = Note(context: context)
                newNote.id = note.id
                newNote.text = note.text
                newNote.dateCreating = Date().timeIntervalSince1970
                remove(note)
                notes.insert(newNote, at: i)
                saveNotes()
                return
            }
        }
    }
    
    func saveNotes() {
        do {
            try context.save()
        } catch {
            print("Error with saving context \(error.localizedDescription)")
        }
    }
    
    func loadNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let data = try context.fetch(request)
            notes = data.sorted(by: { note1, note2 in
                note1.dateCreating < note2.dateCreating
            })
        } catch {
            print("Error with load notes \(error.localizedDescription)")
        }
    }
}
