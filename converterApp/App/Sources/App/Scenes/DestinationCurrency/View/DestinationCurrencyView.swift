import Foundation
import UIKit
import Stevia
import Common
import UICustom

public class DestinationCurrencyView: UICodeView {

    // Properties

    public lazy var titleLabel = UILabel()
    public lazy var table = UITableView()
    public lazy var finalTextField = UITextFieldCustom()
    public lazy var spin = UIActivityIndicatorView()

    public var finalResult: String? {
        didSet {
            finalTextField.textField.text = finalResult
            spin.isHidden = finalResult?.count != 0
        }
    }

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
            table,
            finalTextField,
            spin
        )
    }

    public override func initLayout() {
        table.fillHorizontally().bottom(150).Top == titleLabel.Bottom + 30
        finalTextField.fillHorizontally(padding: 16).Top == table.Bottom + 20
        spin.height(48).Top == table.Bottom + 40
        spin.Left == finalTextField.Right - 35

        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.rowHeight = UITableView.automaticDimension
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = .white
        }
        titleLabel.style { s in
            s.textAlignment = .center
            s.sizeToFit()
            s.numberOfLines = 0
            s.text = "Selecione moeda destino"
        }
        table.style { s in
            s.backgroundColor = .clear
            s.separatorStyle = .singleLine
            s.separatorInset = .zero
            s.showsVerticalScrollIndicator = false
        }
        finalTextField.style { s in
            s.title = "Valor final"
            s.textField.placeholder = "0,00"
            s.textField.isUserInteractionEnabled = false
        }
    }
}


