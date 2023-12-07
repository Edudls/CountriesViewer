//
//  ViewModel.swift
//  CountryList
//
//  Created by DMonaghan on 12/1/23.
//

import UIKit

class CountryListViewModel {
    var countries: [Country] = []
    var filteredCountries: [Country] = []
    
    func getCountries(data: Data, handler: @escaping () -> Void) {
        let decoder = JSONDecoder()
        do {
            self.countries = try decoder.decode([Country].self, from: data)
            self.filteredCountries = self.countries
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        handler()
    }
    
    func getFilteredCountries(text: String) {
        guard text.count > 0 else {
            self.filteredCountries = self.countries
            return
        }
        
        self.filteredCountries = self.countries.filter{$0.name.lowercased().contains(text.lowercased()) || $0.capital.lowercased().contains(text.lowercased())}
    }
}
