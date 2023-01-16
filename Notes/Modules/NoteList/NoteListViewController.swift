import UIKit

class NoteListViewController: BaseViewController<NoteListView> {
    
    var store = NotesStore()
    lazy var dataSource = NoteListDataSource(notes: store.notes)
    
    override func setDelegates(_ view: NoteListView) {
        view.setDelegates(delegate: self, dataSource: self)
    }

    override func setupViewController() {
        applyAppearance()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteTapped))
    }
}

// MARK: - Private func

private extension NoteListViewController {
    func applyAppearance() {
        title = C.Strings.notes
    }
    
    @objc func addNoteTapped(_ sender: UIButton!) {
        let detailNoteVC = DetailNoteViewController()
        detailNoteVC.delegate = self
        navigationController?.pushViewController(detailNoteVC, animated: true)
    }
}

// MARK: - NoteListViewDataSource

extension NoteListViewController: NoteListViewDataSource {
    var notes: [Note] {
        return store.notes
    }
    
    var noteListDataSource: NoteListDataSource {
        return dataSource
    }
}
// MARK: - NoteListViewDelegate

extension NoteListViewController: NoteListViewDelegate {
    func delete(with indexPath: IndexPath) {
        store.remove(notes[indexPath.row])
        dataSource.applySnapshot(notes: notes)
    }
    
    func pressedCell(with indexPath: IndexPath) {
        let detailNoteVC = DetailNoteViewController()
        let note = notes[indexPath.row]
        detailNoteVC.configure(note, self)
        navigationController?.pushViewController(detailNoteVC, animated: true)
    }
}

// MARK: - DetailNoteViewControllerDelegate

extension NoteListViewController: DetailNoteViewControllerDelegate {
    func createNote(_ textView: UITextView) {
        store.append(textView: textView)
        dataSource.applySnapshot(notes: store.notes)
    }
    
    func saveNote(_ note: Note) {
        store.replaceNote(note)
        dataSource.applySnapshot(notes: store.notes)
    }
}
