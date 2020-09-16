//
//  CharacterDetailViewModel.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject{
    func getCharacterApiCall(status: Bool)
    func showLoading(status: Bool)
}
class CharacterDetailViewModel {
    var characterUrl: String?
    var character: Character?
    
    weak var viewDelegate: CharacterDetailViewModelDelegate?
    
    func getCharacter() {
        viewDelegate?.showLoading(status: true)
        NetworkManager.shared.apiCall(url: characterUrl ?? "") {[weak self] (status, data) in
            DispatchQueue.main.async {
                self?.viewDelegate?.showLoading(status: false)
                if let data = data as? Data , status {
                    do {
                        let character = try JSONDecoder().decode(Character.self, from: data)
                        self?.character = character
                        self?.viewDelegate?.getCharacterApiCall(status: true)
                    } catch  {
                        self?.viewDelegate?.getCharacterApiCall(status: false)
                    }
                } else {
                    self?.viewDelegate?.getCharacterApiCall(status: false)
                }
            }
        }
    }
}


