//
//  File.swift
//  
//
//  Created by Thais Sadami on 14/10/21.
//

import Foundation
import UIKit

open class UICodeView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initSubViews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        initSubViews()
        initLayout()
        initStyle()
    }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}
}
