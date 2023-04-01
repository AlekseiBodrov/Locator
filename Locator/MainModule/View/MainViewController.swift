//
//  MainViewController.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    // MARK: - constant
    enum Constant {
        static let heightForHeaderInSection: CGFloat = .rowSize
        static let heightForRow: CGFloat = .rowSize
    }

    // MARK: - property
    var mainViewModel: MainViewModelProtocol
    let mainView: MainViewProtocol

    // MMVM
    init(mainViewModel: MainViewModelProtocol,
         mainView: MainViewProtocol) {
        self.mainViewModel = mainViewModel
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLocationManager()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }

        let person = mainViewModel.personArray[indexPath.row]

        if mainView.selectedPerson == indexPath.row {
            self.mainViewModel.selectedCoordinate = CLLocationCoordinate2D(
                latitude: (mainView.array![indexPath.row].latitude)!,
                longitude: (mainView.array![indexPath.row].longitude)!)
        }

        cell.setupWith(image: person.icon,
                       mainLabel: person.name,
                       discriptionLabel: mainViewModel.getDistanceFor(indexPath: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if mainView.selectedPerson != indexPath.row {
            mainView.selectedPerson = indexPath.row
        } else {
            self.mainView.viewForHeaderInSection.setupWith(
                image: "redPin",
                mainLabel: "Me",
                discriptionLabel: self.mainViewModel.prepareSelfCoordinate())
            mainView.selectedPerson = nil
                mainViewModel.selectedCoordinate = mainViewModel.selfCoordinate
        }
        return true
    }

    func setSelectedCoordinate(location: CLLocationCoordinate2D) {
        mainViewModel.selectedCoordinate = location
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let selectedPerson = mainView.selectedPerson {
            let person = mainView.array![selectedPerson]
            self.mainViewModel.selectedCoordinate = CLLocationCoordinate2D(latitude: (person.latitude)!,
                                                                            longitude: (person.longitude)!)

            let image = self.mainView.array?[selectedPerson].icon

            self.mainView.viewForHeaderInSection.setupWith(image: image!,
                                                            mainLabel: (person.name)!,
                                                            discriptionLabel: "Is Selected")
        } else {
            mainView.viewForHeaderInSection.setupWith(
                image: "redPin",
                mainLabel: "Me",
                discriptionLabel: self.mainViewModel.prepareSelfCoordinate())
        }
        return self.mainView.viewForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.numberOfRows()
    }
}

extension MainViewController {
    // MARK: - flow funcs
    private func configureView() {
        view.addSubview(mainView)
        view.backgroundColor = Color.mainColor

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self,
                                    forCellReuseIdentifier: MainTableViewCell.identifier)

        fetchDataForHeaderInSection()
        updateView()

        //        mainViewModel?.startFetch()
        //        mainViewModel?.error()
        //        mainViewModel?.updateData {}
    }

    private func setConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureViewForHeaderInSection(person: Person?) {
        if let person = person {
            mainView.viewForHeaderInSection.setupWith(image: person.icon, mainLabel: person.name, discriptionLabel: "")
        } else {
            mainView.viewForHeaderInSection.setupWith(image: "redPin", mainLabel: "Me", discriptionLabel: "")
        }

    }

    private func configureLocationManager() {

    }

    private func fetchDataForHeaderInSection() {
        mainViewModel.updateSelfCoordinate = { [weak self] result in
            DispatchQueue.main.async { [unowned self] in
//                self?.mainView.viewForHeaderInSection.discriptionLabel.text = result

                if let selectedPerson = self?.mainView.selectedPerson {
                    let person = self?.mainView.array![selectedPerson]
                    self?.mainViewModel.selectedCoordinate = CLLocationCoordinate2D(latitude: (person?.latitude)!,
                                                                                     longitude: (person?.longitude)!)

                    let image = self?.mainView.array?[selectedPerson].icon

                    self?.mainView.viewForHeaderInSection.setupWith(
                        image: image!, mainLabel: (person?.name)!, discriptionLabel: "Is Selected")
                } else {
                    self?.mainView.viewForHeaderInSection.setupWith(
                        image: "redPin", mainLabel: "Me", discriptionLabel: result)
                }
            }
        }
    }

    private func updateView() {
        mainViewModel.updateViewData = { [unowned self] viewData in
            self.mainView.viewData = viewData
        }
    }

    private func presentAlert() {
        let title = Resources.Alert.title
        let message = Resources.Alert.message
        let cancelTitle = Resources.Alert.cancel
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
