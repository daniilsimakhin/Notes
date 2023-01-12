import UIKit

class NoteListDataSource: NSObject {
    enum Section {
        case main
    }
    
    var notes: [Note]
    var tableView: UITableView?
    var source: UITableViewDiffableDataSource<Section, Note>?
    
    init(notes: [Note]) {
        self.notes = notes
        super.init()
        configureDataSource()
    }
}

extension NoteListDataSource {
    func configureDataSource() {
        guard let tableView = tableView else { return }
        source = UITableViewDiffableDataSource<Section, Note>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableViewCell.reuseIdentifier, for: indexPath) as? NoteListTableViewCell else { fatalError("Don't dequeue cell with - \(NoteListTableViewCell.reuseIdentifier)") }
            cell.configure(note: self.notes[indexPath.row])
            return cell
        })
        applySnapshot(notes: notes)
    }
    
    func applySnapshot(notes: [Note]) {
        self.notes = notes
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.notes)
        
        source?.apply(snapshot)
    }
}
