//
//  ViewController.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

/*
 //https://rickandmortyapi.com/api/episode/
 
 Create an iOS app to show the list of Episodes from the show Rick and Morty.
 API Doc: https://rickandmortyapi.com/documentation/#episode
 Application Requirements: • Fetch one page of episodes at a time • Show a list of episodes • When user scrolls to the end of content, fetch the next page of episodes (if available) • Tapping on a show should take the user to a new screen showing episode details
 Development Requirements: • Use the design pattern of you choice (MVC, MVVM, VIPER, etc) • UI can be designed in your preferred way (SwiftUI, Storyboard, Programmatically) • The code must be shared on GitHub or BitBucket • Commits should always have clear descriptions of work done • Any 3rd party frameworks/assets used must be licensed for public use
 Plus Points: • Make it pretty • Comment code where needed • Add unit tests • Add character list to detail screen and make those take the user to character details • Cache data for offline use
 
 
 */

import UIKit

class EpisodeListViewController: UIViewController {
    
    // MARK: - IBOutlet Connection
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    var viewModel = EpisodeListViewModel()
    
    // MARK: - View Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.viewDelegate = self
        viewModel.currentPage = 0
        self.title = "Episodes"
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - ViewDelegate extension
extension EpisodeListViewController: ViewDelegate {
    
    /// Show or hide loading indicator based on `status`
    func showLoading(status: Bool) {
        if status {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            
        } else {
            self.view.activityStopAnimating()
            
        }
    }
    
    /// callback for Episode API call.
    func getEpisodeApiCall(status: Bool) {
        if status {
            tableView.reloadData()
        } else {
            self.presentAlert(withTitle: "Alert", message: "Something went wrong")
        }
    }
    
    
}

// MARK: - UITableViewDelegate extension
// MARK: - UITableViewDataSource extension


extension EpisodeListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeableViewCell", for: indexPath) as? EpisodeableViewCell else {
            fatalError()
        }
        cell.episodeNameLabel.text = viewModel.results[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "EpisodeDetailViewController")as? EpisodeDetailViewController else {
            return
        }
        vc.episodeDetailViewModel.result = viewModel.results[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.results.count  {
            viewModel.currentPage = (viewModel.currentPage ?? 0) + 1
        }
    }
    
    
}

