import UIKit

class NoteListViewController: UIViewController {
    
    var notes = [Note(id: "0", text: "Hello1"), Note(id: "1", text: "Hello2"), Note(id: "2", text: "Hello3")]
    lazy var dataSource = NoteListDataSource(notes: notes)
    
    override func loadView() {
        let noteListView = NoteListView(delegate: self, dataSource: self)
        view = noteListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyAppearance()
    }
}

private extension NoteListViewController {
    func applyAppearance() {
        title = C.Strings.notes
    }
}

extension NoteListViewController: NoteListViewDataSource {
    var noteListDataSource: NoteListDataSource {
        return dataSource
    }
}

extension NoteListViewController: NoteListViewDelegate {
    func delete(with indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
    }
    
    func pressedCell(with indexPath: IndexPath) {
        print("Переход в детальное окно")
    }
}
