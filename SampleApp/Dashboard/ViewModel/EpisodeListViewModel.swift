//
//  EpisodeListViewModel.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import Foundation

protocol ViewDelegate: AnyObject{
    func getEpisodeApiCall(status: Bool)
    func showLoading(status: Bool)
}

class EpisodeListViewModel: NSObject {
    var results =  [Result]()
    var currentPage : Int? {
        didSet {
            getEpisodes(pageNumber: "\(currentPage ?? 0)")
        }
    }
    
    weak var viewDelegate: ViewDelegate?
    
    func getEpisodes(pageNumber: String) {
        viewDelegate?.showLoading(status: true)
        NetworkManager.shared.apiCall(url: "https://rickandmortyapi.com/api/episode/?page=\(pageNumber)") {[weak self] (status, data) in
            DispatchQueue.main.async {
                self?.viewDelegate?.showLoading(status: false)
                if let data = data as? Data , status {
                    do {
                        let episodes = try JSONDecoder().decode(Episode.self, from: data)
                        self?.results.append(contentsOf: episodes.results ?? []) 
                        self?.viewDelegate?.getEpisodeApiCall(status: true)
                    } catch  {
                        self?.viewDelegate?.getEpisodeApiCall(status: false)
                    }
                } else {
                    self?.viewDelegate?.getEpisodeApiCall(status: false)
                }
            }
        }
    }
}
