//
//  WeatherCell.swift
//  task4_app
//
//  Created by Murat on 30.08.2023.
//

import UIKit


class WeatherCell : UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel : WeatherViewModel?{
        didSet{
            configure()
        }
    }

    var cityLabel : UILabel = {
       
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        return label
        
    }()
    
     var conditionImageView : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
         iv.image = UIImage(systemName: "cloud")?.withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 50, width: 50)
        return iv
    }()
    
     var tempLabel : UILabel = {
       
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        return label
    }()
    
    var maxAndMinTempLabel : UILabel = {
        
       let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        backgroundColor = .white
        
       let stack = UIStackView(arrangedSubviews: [cityLabel,conditionImageView,tempLabel,maxAndMinTempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        stack.distribution = .fillEqually
        
        
        addSubview(stack)
        stack.anchor(top: self.topAnchor,left: self.leftAnchor,bottom: self.bottomAnchor,right: self.rightAnchor,paddingTop: 8,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
    }
    
    func configure(){
        
        guard let viewModel = viewModel else {return}
        
        cityLabel.text = viewModel.city
        tempLabel.text = "\(viewModel.temperature) °C"
        maxAndMinTempLabel.text = "Max : \(viewModel.maxTemperature) °C - Min : \(viewModel.minTemperature) °C"
        conditionImageView.image = UIImage(systemName: viewModel.conditionName)
        
    }
    
}
