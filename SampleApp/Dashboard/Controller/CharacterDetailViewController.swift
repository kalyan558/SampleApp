//
//  CharacterDetailViewController.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel = CharacterDetailViewModel()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        viewModel.getCharacter()
        
        // Do any additional setup after loading the view.
    }
    
    private func updateUI(){
        nameLabel.text = "Name: \(viewModel.character?.name ?? "")"
        genderLabel.text = "Gender: \(viewModel.character?.gender ?? "")"
        locationLabel.text = "Location: \(viewModel.character?.location?.name ?? "")"
        self.title = "\(viewModel.character?.name ?? "")"

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension CharacterDetailViewController : CharacterDetailViewModelDelegate {
    func getCharacterApiCall(status: Bool) {
        if status {
            updateUI()
        } else {
            self.presentAlert(withTitle: "Alert", message: "Something went wrong")
        }
    }
    
    func showLoading(status: Bool) {
        if status {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            
        } else {
            self.view.activityStopAnimating()
            
        }
    }
    
    
}
