import UIKit

protocol DetailNoteViewControllerDelegate: AnyObject {
    func saveNote(_ note: Note)
    func createNote(_ text: UITextView)
}

class DetailNoteViewController: BaseViewController<DetailNoteView> {
    
    var delegate: DetailNoteViewControllerDelegate?
    var note: Note?
    
    override func setupViewController() {
        applyAppearance()
    }
    
    override func setDelegates(_ view: DetailNoteView) {
        view.delegate = self
        view.dataSource = self
    }
}

private extension DetailNoteViewController {
    func applyAppearance() {
        
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

extension DetailNoteViewController: DetailNoteViewDelegate, DetailNoteViewDataSource {
    func noteDidEndEditing(textView: UITextView) {
        guard let note = note else {
            delegate?.createNote(textView)
            return
        }
        note.text = textView.text
        delegate?.saveNote(note)
    }
}
