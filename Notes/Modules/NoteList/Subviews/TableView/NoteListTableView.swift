import UIKit

protocol NoteListTableViewActionDelegate: AnyObject {
    func deleteNote(with indexPath: IndexPath)
    func didPressedCell(with indexPath: IndexPath)
}

class NoteListTableView: UITableView {
    
    var actionDelegate: NoteListTableViewActionDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        applyAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private func

private extension NoteListTableView {
    func applyAppearance() {
        register(NoteListTableViewCell.self,
                 forCellReuseIdentifier: NoteListTableViewCell.reuseIdentifier)
        rowHeight = 80
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UITableViewDelegate

extension NoteListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: C.Strings.delete) { [weak self] _, _, completionHandler in
            
            self?.actionDelegate?.deleteNote(with: indexPath)
            completionHandler(true)
        }
        deleteAction.image = C.Images.Core.trash
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionDelegate?.didPressedCell(with: indexPath)
    }
}
