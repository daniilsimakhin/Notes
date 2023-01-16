import UIKit

protocol DetailNoteViewDelegate: AnyObject {
    func noteDidEndEditing(textView: UITextView)
}

protocol DetailNoteViewDataSource: AnyObject {
    var note: Note? { get set }
}

class DetailNoteView: BaseView {
    
    var delegate: DetailNoteViewDelegate?
    var dataSource: DetailNoteViewDataSource?
    
    private lazy var textView: MyTextView = {
        var textView = MyTextView()
        textView.adjustsFontForContentSizeCategory = true
        textView.font = .preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.allowsEditingTextAttributes = true
        textView.isEditable = true
        return textView
    }()
    
    override func setupView() {
        applyAppearance()
        textView.becomeFirstResponder()
    }
}

// MARK: - Private func

private extension DetailNoteView {
    func applyAppearance() {
        addSubview(textView)
        applyConstraints()
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
}

// MARK: - UITextViewDelegate

extension DetailNoteView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.noteDidEndEditing(textView: textView)
    }
}

// MARK: - Public func

extension DetailNoteView {
    func configure(note: Note) {
        textView.text = note.t
    }
}

class MyTextView: UITextView {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController = UIMenuController.shared
        if var menuItems = menuController.menuItems,
            (menuItems.map { $0.action }).elementsEqual([.toggleBoldface, .toggleItalics, .toggleUnderline]) {
            menuItems.append(UIMenuItem(title: "Strikethrough", action: .toggleStrikethrough))
            menuController.menuItems = menuItems
        }
        return super.canPerformAction(action, withSender: sender)
    }

    @objc func toggleStrikethrough(_ sender: Any?) {
        print("Strikethrough button was pressed")
    }

}

fileprivate extension Selector {
    static let toggleBoldface = #selector(MyTextView.toggleBoldface(_:))
    static let toggleItalics = #selector(MyTextView.toggleItalics(_:))
    static let toggleUnderline = #selector(MyTextView.toggleUnderline(_:))
    static let toggleStrikethrough = #selector(MyTextView.toggleStrikethrough(_:))
}
