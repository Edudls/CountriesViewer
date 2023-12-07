//
//  CountryServiceHandler.swift
//  CountryList
//
//  Created by DMonaghan on 12/2/23.
//

import Foundation

class CountryServiceHandler {
    
    static func getCountriesData(handler: @escaping (Any?) -> Void) {
        guard let countriesURL = URL(string: CountryConstants.countriesURL.rawValue) else {
            print("error getting url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: countriesURL, completionHandler: {data, res, err in
            guard err == nil else {
                print(err?.localizedDescription ?? "undefined error")
                handler(nil)
                return
            }
            if let safeData = data {
                handler(safeData)
                return
            }
            handler(nil)
        })
        task.resume()
    }
}
