//
//  File.swift
//  
//
//  Created by Thais Sadami on 14/10/21.
//

import UIKit
import Stevia
import Common
import UICustom

public protocol HomeViewPresenting: AnyObject {
    func getSymbols()
    func didSelectCurrency(_ currency: String)
}

public class HomeViewController: UIMainCodeViewController<HomePresenter, HomeView> {

    public var result: [String]? = [] {
        didSet {
            mainView.table.isHidden = result?.count == 0
            mainView.table.reloadData()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func setupView() {
        mainView.table.dataSource = self
        mainView.table.delegate = self
        if #available(iOS 11.0, *) {
            mainView.titleLabel.centerHorizontally().Top == view.safeAreaLayoutGuide.Top + 40
        } else {
            mainView.titleLabel.centerHorizontally().top(40)
        }
    }

    override open func setupPresenter() {
        presenter.viewController = self
        presenter.getSymbols()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)
        cell.textLabel?.text = result?[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = result?[indexPath.row]
        presenter.didSelectCurrency(currency ?? "")
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: HomeViewable {

    func showAlert(_ message: String) {
        UIAlertAction().showAlert(viewController: self, title:"", message: message)
    }

    func startLoading() {
        mainView.spin.startAnimating()
    }

    func stopLoading() {
        mainView.spin.stopAnimating()
    }
}

