//
//  ViewController.swift
//  task5_appp
//
//  Created by Murat on 31.08.2023.
//

import UIKit
import MediaPlayer
import SDWebImage

private let identifer = "PlaylistCellIdentifier"

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var playlists: [MPMediaItemCollection] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.register(PlaylistCell.self, forCellReuseIdentifier: identifer)
        
        tableView.rowHeight = 70
        
    }
    
    //MARK: - Helpers
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
          case 0:
            playlists.removeAll()
              break
          case 1:
              fetchAppleMusicPlaylists()
              tableView.reloadData()
              break
          case 2:
            playlists.removeAll()
            tableView.reloadData()
              break
          default:
              break
          }
    }
    
    func fetchAppleMusicPlaylists() {
          let query = MPMediaQuery.playlists()
          if let playlistCollections = query.collections {
              playlists = playlistCollections
          }
      }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer) as! PlaylistCell
        
        let playlistText = playlists[indexPath.row].value(forProperty: MPMediaPlaylistPropertyName) as? String
        
        let playlistCount = playlists[indexPath.row].items.count
        
        let artwork = playlists[indexPath.row].items.first
    
        cell.playlistName.text = playlistText
        cell.playlistCount.text = "\(playlistCount) Songs"
        cell.playlistImage.image = artwork?.artwork?.image(at: CGSize(width: 40, height: 40))
        
        return cell
    }
}

