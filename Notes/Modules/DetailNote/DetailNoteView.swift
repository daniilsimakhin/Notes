import UIKit

protocol DetailNoteViewDelegate: AnyObject {
    func noteDidEndEditing(text: String)
}

class DetailNoteView: BaseView {
    
    var delegate: DetailNoteViewDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.adjustsFontForContentSizeCategory = true
        textView.font = .preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()

    override func setupView() {
        applyAppearance()
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
        delegate?.noteDidEndEditing(text: textView.text)
    }
}

// MARK: - Public func

extension DetailNoteView {
    func configure(note: Note) {
        textView.text = note.text
    }
}
