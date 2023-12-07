//
//  ViewController.swift
//  CountryList
//
//  Created by DMonaghan on 12/1/23.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    
    let viewModel = CountryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    func setupTableView() {
        searchBar?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "cell")
        CountryServiceHandler.getCountriesData(handler: { [weak self] data in
            guard let safeData = data as? Data else {
                print("Error fetching countries data")
                return
            }
            self?.viewModel.getCountries(data: safeData, handler: {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            })
        })
    }
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CountryCell else {
            return UITableViewCell()
        }
        cell.locationLabel?.text = "\(viewModel.filteredCountries[indexPath.row].name), \(viewModel.filteredCountries[indexPath.row].region)"
        cell.codeLabel?.text = viewModel.filteredCountries[indexPath.row].code
        cell.capitalLabel?.text = viewModel.filteredCountries[indexPath.row].capital
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.filteredCountries[indexPath.row])
        guard let cell = self.tableView?.cellForRow(at: indexPath) as? CountryCell else {
            print("Error fetching tableview cell")
            return
        }
        print("\(cell.capitalLabel?.text ?? "capital not found"), \(cell.locationLabel?.text ?? "region not found") - \(cell.codeLabel?.text ?? "code not found")")
    }
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getFilteredCountries(text: searchText)
        self.tableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getFilteredCountries(text: searchBar.text ?? "")
        self.tableView?.reloadData()
        self.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getFilteredCountries(text: searchBar.text ?? "")
        self.tableView?.reloadData()
        self.resignFirstResponder()
    }
}
