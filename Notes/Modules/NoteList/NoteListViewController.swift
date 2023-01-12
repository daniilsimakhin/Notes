import UIKit

class NoteListViewController: UIViewController {
    
    var store = NotesStore()
    lazy var dataSource = NoteListDataSource(notes: store.notes)
    var baseView: NoteListView {
        return view as! NoteListView
    }
    
    override func loadView() {
        let noteListView = NoteListView(delegate: self, dataSource: self)
        view = noteListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let alert = UIAlertController(title: "Add note", message: "Enter a text", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Some default text"
        }

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            guard let text = alert?.textFields?[0].text else { return }
            self.store.append(text: text)
            self.dataSource.applySnapshot(notes: self.store.notes)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
        store.remove(note: notes[indexPath.row])
        dataSource.applySnapshot(notes: notes)
    }
    
    func pressedCell(with indexPath: IndexPath) {
        print("Переход в детальное окно")
    }
}
