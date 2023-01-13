import UIKit

protocol NoteListViewDelegate: AnyObject {
    func delete(with indexPath: IndexPath)
    func pressedCell(with indexPath: IndexPath)
}

protocol NoteListViewDataSource: AnyObject {
    var notes: [Note] { get }
    var noteListDataSource: NoteListDataSource { get }
}

class NoteListView: BaseView {
    
    var delegate: NoteListViewDelegate?
    var dataSource: NoteListViewDataSource?
    
    private lazy var noteTableView: NoteListTableView = {
        let tableView = NoteListTableView(frame: .zero, style: .grouped)
        tableView.actionDelegate = self
        tableView.dataSource = dataSource?.noteListDataSource.source
        dataSource?.noteListDataSource.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

// MARK: - Public func

extension NoteListView {
    func setDelegates(delegate: NoteListViewDelegate,
                      dataSource: NoteListViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
        applyAppearance()
    }
}

// MARK: - Private func

private extension NoteListView {
    func applyAppearance() {
        applyConstraints()
        dataSource?.noteListDataSource.configureDataSource()
    }
    
    func applyConstraints() {
        addSubview(noteTableView)
        NSLayoutConstraint.activate([
            noteTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            noteTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            noteTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            noteTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
    }
}

// MARK: - NoteListTableViewActionDelegate

extension NoteListView: NoteListTableViewActionDelegate {
    func deleteNote(with indexPath: IndexPath) {
        delegate?.delete(with: indexPath)
    }
    
    func didPressedCell(with indexPath: IndexPath) {
        delegate?.pressedCell(with: indexPath)
    }
}
