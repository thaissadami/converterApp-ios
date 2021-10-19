//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

import UIKit
import Stevia
import Common

public class UITextFieldCustom: UICodeView {

    // Properties

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private lazy var titleLabel = UILabel()
    public lazy var textField = UITextField()
    private lazy var backgroundTextFieldView = UIView()

    private let stackTextFieldView = UIStackView()
    private let stackHelperView = UIStackView()

    // Lifecycle

    open override func initSubViews() {
        subviews(
            titleLabel,
            backgroundTextFieldView.subviews(
                stackTextFieldView.asv(
                    textField
                )
            )
        )
    }

    open override func initLayout() {
        titleLabel.fillHorizontally(padding: 8).top(0).Bottom == backgroundTextFieldView.Top
        backgroundTextFieldView.fillHorizontally().Bottom == stackHelperView.Top
        stackHelperView.fillHorizontally(padding: 8).bottom(0)
        stackTextFieldView.fillVertically().fillHorizontally(padding: 8).height(48)
    }

    // swiftlint:disable function_body_length
    open override func initStyle() {
//        self.textField.delegate = self

        style { s in
            let tapSelection = UITapGestureRecognizer(target: self, action: #selector(touchSelection))
            s.addGestureRecognizer(tapSelection)
        }
        titleLabel.style { s in
            s.textColor = .lightGray
            s.textAlignment = .left
            s.sizeToFit()
        }
        backgroundTextFieldView.style { s in
            s.layer.cornerRadius = 8.0
            s.backgroundColor = .init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        }
        stackTextFieldView.style { s in
            s.axis = .horizontal
            s.alignment = .center
            s.distribution = .fill
            s.spacing = 8
        }
        textField.style { s in
        }
        stackHelperView.style { s in
            s.axis = .horizontal
            s.alignment = .center
            s.distribution = .fill
        }
    }

    @objc func touchSelection() {
        textField.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension UITextFieldCustom: UITextFieldDelegate {

//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    }
}


