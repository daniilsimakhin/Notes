import UIKit

protocol DetailNoteViewControllerDelegate: AnyObject {
    func saveNote(_ note: Note)
    func createNote(_ text: String)
}

class DetailNoteViewController: BaseViewController<DetailNoteView> {
    
    var delegate: DetailNoteViewControllerDelegate?
    var note: Note?
    
    override func setDelegates(_ view: DetailNoteView) {
        view.delegate = self
    }
}

// MARK: - Public func

extension DetailNoteViewController {
    func configure(_ note: Note, _ delegate: DetailNoteViewControllerDelegate) {
        self.delegate = delegate
        self.note = note
        
        baseView.configure(note: note)
    }
}

// MARK: - DetailNoteViewDelegate

extension DetailNoteViewController: DetailNoteViewDelegate {
    func noteDidEndEditing(text: String) {
        guard let note = note else {
            delegate?.createNote(text)
            return
        }
        note.text = text
        
        delegate?.saveNote(note)
    }
}
