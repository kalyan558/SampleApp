//
//  EpisodeDetailViewController.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var episodeDetailViewModel = EpisodeDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        updateUI()
          self.title = "\(episodeDetailViewModel.result?.name ?? "")"
        
        // Do any additional setup after loading the view.
    }
    
    private func updateUI(){
        episodeNameLabel.text = "Name: \(episodeDetailViewModel.result?.name ?? "")"
        episodeLabel.text = "Episode: \(episodeDetailViewModel.result?.episode ?? "")"
        airDateLabel.text = "Air Date: \(episodeDetailViewModel.result?.airDate ?? "")"
        collectionView.reloadData()
    }
    
    private func registerCollectionViewCell(){
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
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

extension EpisodeDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.episodeDetailViewModel.result?.characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath as IndexPath) as? CharacterCollectionViewCell else { fatalError() }
        if let charcterURl = self.episodeDetailViewModel.result?.characters?[indexPath.row] {
            var str = charcterURl.replacingOccurrences(of: "https://rickandmortyapi.com/api/", with: "")
              str = str.replacingOccurrences(of: "/", with: " ")
            cell.characterNameLabel.text = str
        }
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let vc = self.storyboard?.instantiateViewController(identifier: "CharacterDetailViewController")as? CharacterDetailViewController else {
                   return
               }
        vc.viewModel.characterUrl = episodeDetailViewModel.result?.characters?[indexPath.row]
               self.navigationController?.pushViewController(vc, animated: true)
    }
}
