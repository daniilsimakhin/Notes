import Foundation
import CoreData
import UIKit

struct NotesStore {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes: [Note]
    
    init() {
        notes = []
        loadNotes()
    }
    
    mutating func append(text: String) {
        let note = Note(context: context)
        note.text = text
        note.id = UUID().uuidString
        
        while notes.contains(where: { $0.id == note.id }) {
            note.id = UUID().uuidString
        }
        notes.append(note)
        saveNotes()
    }
    
    mutating func remove(note: Note) {
        guard let index = notes.firstIndex(of: note) else { return }
        context.delete(notes[index])
        notes.remove(at: index)
        saveNotes()
    }
    
    func getNote(index: Int) -> Note? {
        guard index < notes.count else { return nil }
        return notes[index]
    }
    
    func saveNotes() {
        do {
            try context.save()
        } catch {
            print("Error with saving context \(error.localizedDescription)")
        }
    }
    
    mutating func loadNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error with load notes \(error.localizedDescription)")
        }
    }
}
