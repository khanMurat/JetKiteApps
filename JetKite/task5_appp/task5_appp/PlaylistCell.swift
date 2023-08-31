//
//  PlaylistCell.swift
//  task5_appp
//
//  Created by Murat on 31.08.2023.
//

import UIKit


class PlaylistCell : UITableViewCell {
    
    //MARK: - Properties
    
    var playlistImage : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "music.note.list")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.white
        iv.setDimensions(height: 40, width: 40)
        return iv
    }()
    
    var playlistName : UILabel = {
       
        let lbl = UILabel()
        lbl.text = "Playlist"
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    var playlistCount : UILabel = {
       
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textColor = .white
        lbl.font = .italicSystemFont(ofSize: 8)
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        self.backgroundColor = .black
        
        addSubview(playlistImage)
        playlistImage.centerY(inView: self,leftAnchor: self.leftAnchor,paddingLeft: 8)
        
        addSubview(playlistName)
        playlistName.centerY(inView: playlistImage,leftAnchor: playlistImage.rightAnchor,paddingLeft: 8)
        
        addSubview(playlistCount)
        playlistCount.anchor(top: playlistName.bottomAnchor,left: playlistImage.rightAnchor,right: playlistName.rightAnchor,paddingTop: 2,paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
