import Foundation
import UIKit
import Stevia
import Common
import UICustom

public class HomeView: UICodeView {

    // Properties

    public lazy var titleLabel = UILabel()
    public lazy var valueTextField = UITextFieldCustom()
    private lazy var tableLabel = UILabel()
    public lazy var table = UITableView()
    public lazy var spin = UIActivityIndicatorView()

    // Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
        initLayout()
        initStyle()
    }

    private func initSubviews() {
        subviews(
            titleLabel,
            valueTextField,
            tableLabel,
            table,
            spin
        )
    }

    public override func initLayout() {
        valueTextField.fillHorizontally(padding: 64).height(48).Top == titleLabel.Bottom + 20
        tableLabel.fillHorizontally(padding: 64).height(48).Top == valueTextField.Bottom + 30
        table.fillHorizontally().bottom(0).Top == tableLabel.Bottom + 10

        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.rowHeight = UITableView.automaticDimension

        spin.centerHorizontally().height(48).Top == table.Top + 20
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = .white
        }
        titleLabel.style { s in
            s.textAlignment = .center
            s.sizeToFit()
            s.numberOfLines = 0
            s.text = "Conversão de moedas"
        }
        valueTextField.style { s in
            s.title = "Informe um valor para conversão"
            s.textField.placeholder = "0,00"
            s.textField.keyboardType = .numberPad
        }
        tableLabel.style { s in
            s.textAlignment = .center
            s.sizeToFit()
            s.numberOfLines = 0
            s.text = "Selecione a moeda"
        }
        table.style { s in
            s.backgroundColor = .clear
            s.separatorStyle = .singleLine
            s.separatorInset = .zero
            s.showsVerticalScrollIndicator = false
        }
    }
}


