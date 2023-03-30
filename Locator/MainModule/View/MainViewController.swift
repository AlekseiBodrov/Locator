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
    var mainViewModel: MainViewModelProtocol?
    var mainView: MainViewProtocol?

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

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        self.mainViewModel?.selfCoordinate = location
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let person = mainViewModel?.personArray[indexPath.row] else
        { return UITableViewCell() }
        cell.setupWith(image: person.icon!, mainLabel: person.name!, discriptionLabel: "\(Int((mainViewModel?.personArray[indexPath.row].getDistance(from: CLLocation.init(latitude: (mainViewModel?.selectedCoordinate.latitude)!, longitude: (mainViewModel?.selectedCoordinate.longitude)!)))!)) m."
        )
        return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if mainView?.selectedPerson != indexPath.row {
            mainView?.selectedPerson = indexPath.row
        } else {
            self.mainView?.viewForHeaderInSection.setupWith(image: "redPin",
                                                            mainLabel: "Me",
                                                            discriptionLabel: "")
            mainView?.selectedPerson = nil
            if let coordinate = mainViewModel?.selfCoordinate {
                mainViewModel?.selectedCoordinate = coordinate
            }
        }
        return true
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let selectedPerson = mainView?.selectedPerson {
            let person = self.mainView?.array![selectedPerson]
            self.mainViewModel?.selectedCoordinate = CLLocationCoordinate2D(latitude: (person?.latitude)!,
                                                                            longitude: (person?.longitude)!)

            let image = self.mainView?.array?[selectedPerson].icon

            self.mainView?.viewForHeaderInSection.setupWith(image: image!, mainLabel: (person?.name)!, discriptionLabel: "Is Selected")
        } else {
            //            self.mainView?.viewForHeaderInSection.setupWith(image: "redPin", mainLabel: "Me", discriptionLabel: "\(self.viewModel?.updateSelfCoordinate)")
        }
        return self.mainView?.viewForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel?.numberOfRows() ?? 0
    }
}

extension MainViewController {
    // MARK: - flow funcs
    private func configureView() {
        guard let mainView = mainView else { return }
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
        guard let mainView = mainView else { return }
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
            mainView?.viewForHeaderInSection.setupWith(image: person.icon, mainLabel: person.name, discriptionLabel: "")
        } else {
            mainView?.viewForHeaderInSection.setupWith(image: "redPin", mainLabel: "Me", discriptionLabel: "")
        }

    }

    private func configureLocationManager() {
        guard let viewModel = self.mainViewModel else { return }
        viewModel.locationManager.delegate = self
        viewModel.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        viewModel.locationManager.requestAlwaysAuthorization()
        viewModel.locationManager.startUpdatingLocation()
    }

    private func fetchDataForHeaderInSection() {
        self.mainViewModel?.updateSelfCoordinate = { [weak self] result in
            DispatchQueue.main.async { [unowned self] in
                self?.mainView?.viewForHeaderInSection.discriptionLabel.text = result

                if let selectedPerson = self!.mainView?.selectedPerson {
                    let person = self?.mainView?.array![selectedPerson]
                    self!.mainViewModel?.selectedCoordinate = CLLocationCoordinate2D(latitude: (person?.latitude)!,
                                                                                     longitude: (person?.longitude)!)

                    let image = self?.mainView?.array?[selectedPerson].icon

                    self?.mainView?.viewForHeaderInSection.setupWith(image: image!, mainLabel: (person?.name)!, discriptionLabel: "Is Selected")
                } else {
                    self?.mainView?.viewForHeaderInSection.setupWith(image: "redPin", mainLabel: "Me", discriptionLabel: result)
                }
            }
        }
    }

    private func updateView() {
        mainViewModel?.updateViewData = { [weak self] viewData in
            self?.mainView?.viewData = viewData
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
