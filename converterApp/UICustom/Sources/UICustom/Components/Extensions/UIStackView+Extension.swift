//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

import UIKit

public extension UIStackView {

    @discardableResult
    func asv(_ arrengedSubviews: UIView...) -> Self {
        asv(arrengedSubviews)
        return self
    }

    @discardableResult
    func asv(_ arrengedSubviews: [UIView]) -> Self {
        arrengedSubviews.forEach { sv in
            addArrangedSubview(sv)
        }
        return self
    }

    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        arrangedSubviews.reduce([UIView](), { $0 + [removeArrengedSubviewProperly($1)] })
    }

    @discardableResult
    func removeArrengedSubviewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}

