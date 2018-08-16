//
//  ViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit
import CoreLocation
import Toast_Swift

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var arrayWeathers: [[Weather]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        initLocationService()
        locationRequest()
    }
    
    // MARK: request
    
    private func locationRequest() {
        LocationServices.shared.getAdress { [weak self] locality in
            guard let `self` = self else { return }
            `self`.title = locality
            `self`.weatherRequest(locality: locality)
        }
    }
    
    private func weatherRequest(locality: String) {
        view.makeToastActivity(.center)
        APIs.shared.requestForecastBy(locality: locality) { [weak self] (arrayWeathers, error) in
            guard let `self` = self else { return }
            `self`.view.hideToastActivity()
            if let arrayWeathers = arrayWeathers, arrayWeathers.count > 0 {
                `self`.title = locality
                `self`.arrayWeathers = arrayWeathers
                `self`.tableView.reloadData()
            } else if let error = error {
                `self`.view.makeToast(error.localizedDescription, position: .center)
            } else {
                `self`.view.makeToast(NSLocalizedString("No result", comment:""), position: .center)
            }
        }
    }
    
    // MARK: Prepare segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "TodayIdentifier" {
            guard let todayViewController = segue.destination as? TodayViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            todayViewController.locality = self.title
        }
    }
    
    // MARK: Action
    
    @IBAction func onNowBarBtnClick(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "TodayIdentifier", sender: self)
    }
    
    
}

// MARK: TableView Delegate

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeathers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell
        if let cell = cell as? WeatherTableViewCell {
            cell.weathers = arrayWeathers[indexPath.row]
            cell.row = indexPath.row
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .none
        return cell!
    }
}

// MARK: Location delegate

extension ViewController: CLLocationManagerDelegate {
    func initLocationService(){
        LocationServices.shared.locManager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationRequest()
        }
    }
}

// MARK: SearchBar delegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        weatherRequest(locality: text)
        searchController.isActive = false
    }
}
