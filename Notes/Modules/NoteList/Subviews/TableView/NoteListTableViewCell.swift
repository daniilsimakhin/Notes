import UIKit

class NoteListTableViewCell: UITableViewCell {
    enum Constraints {
        static let offset: CGFloat = 10
    }
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyAppearance()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private func

private extension NoteListTableViewCell {
    func applyAppearance() {
        contentView.addSubview(noteLabel)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.offset),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.offset),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.offset),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.offset),
        ])
    }
}

// MARK: - Public func

extension NoteListTableViewCell {
    func configure(note: Note) {
        noteLabel.text = note.text
    }
}
