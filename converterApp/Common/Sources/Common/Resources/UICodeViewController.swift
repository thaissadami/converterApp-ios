//
//  File.swift
//  
//
//  Created by Thais Sadami on 14/10/21.
//

import UIKit

open class UICodeViewController<T>: UIViewController {

    public let presenter: T

    public init(presenter: T) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) { fatalError() }
}

open class UIMainCodeViewController<T, U: UIView>: UIViewController {

    public let presenter: T
    public private(set) lazy var mainView = U()

    public init(presenter: T) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    open override func loadView() {
        view = mainView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPresenter()
    }

    public required init?(coder: NSCoder) { fatalError() }

    open func setupView() {}
    open func setupPresenter() {}
}

