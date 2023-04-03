//
//  MainView.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit
import CoreLocation

protocol MainViewProtocol: UIView {
    var activityIndicator: UIActivityIndicatorView { get }
    var tableView: UITableView { get }
    var viewForHeaderInSection: ViewForHeaderInSection { get set }
    var viewData: ViewData { get set }
}

final class MainView: UIView, MainViewProtocol {

    // MARK: - property
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }

    var tableView = UITableView()
    var viewForHeaderInSection = ViewForHeaderInSection()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - life cycle funcs
    #warning("Создал класс CommonInitView. Наследуйся от него и вызывай конфигурационные функции в методе commonInit()")
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    func commonInit() {
        addSubViews()
        configureView()
        setConstraints()
    }

    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        switch viewData {
        case .initial:
            update(viewData: nil, isHidden: true)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let success):
            update(viewData: success, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .failure(let failure):
            update(viewData: failure, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }

        tableView.reloadData()
    }
}

extension MainView {
    // MARK: - flow funcs
    private func addSubViews() {
        addSubview(viewForHeaderInSection)
        addSubview(activityIndicator)
        addSubview(tableView)
    }

    private func configureView() {
        backgroundColor = Color.mainColor
        viewForHeaderInSection.backgroundColor = Color.secondaryColor

        activityIndicator.color = Color.secondaryColor
        activityIndicator.hidesWhenStopped = true
    }

    private func update(viewData: [Person]?, isHidden: Bool) {
        tableView.isHidden = isHidden
        viewForHeaderInSection.isHidden = isHidden
        tableView.reloadData()
    }

    private func setConstraints() {
        tableView.viewAnchors(self)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
