//
//  ViewController.swift
//  task2_app
//
//  Created by Murat on 28.08.2023.
//

import UIKit
import UserNotifications

class CountdownViewController: UIViewController,UNUserNotificationCenterDelegate {

    
    //MARK: - Properties
    
    private let frameView : UIView = {
       
        let uv = UIView()
        uv.setDimensions(height: 80, width: 140)
        uv.layer.borderWidth = 2
        uv.layer.borderColor = UIColor.black.cgColor
        return uv
        
    }()
    
    private let label : UILabel = {
       
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
        
    }()
    
    private let pickerView : UIPickerView = {
        
       let picker = UIPickerView()
        picker.setDimensions(height: 250,width: 300)
        picker.tintColor = .black
        return picker
    }()
    
    private lazy var startAndStopButton : UIButton = {
      
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 130)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    private lazy var setAndResetButton : UIButton = {
      
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 130)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(handleResetTimer), for: .touchUpInside)
        return button
    }()
    
    var viewModel = CountdownViewModel()


    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()

    }
    
    //MARK: - Actions
    
    @objc func handleResetTimer() {
        viewModel.resetTimer()
         updateCountdownLabel()
     }
    

    @objc func startTimer() {
        viewModel.startTimer { time in
            self.updateCountdownLabel()
            self.viewModel.delegate = self
        }
    }
    
    //MARK: - Helpers

     func updateCountdownLabel() {
         let minutes = Int(viewModel.currentTime) / 60
         let seconds = Int(viewModel.currentTime) % 60

         label.text = String(format: "%02d:%02d", minutes,seconds)
     }
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        view.addSubview(pickerView)
        pickerView.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        view.addSubview(frameView)
        frameView.centerX(inView: view,topAnchor: pickerView.bottomAnchor,paddingTop: 16)
        
        frameView.addSubview(label)
        label.centerX(inView: frameView)
        label.centerY(inView: frameView)
        
        view.addSubview(startAndStopButton)
        startAndStopButton.centerX(inView: view,topAnchor: frameView.bottomAnchor,paddingTop: 32)
        
        view.addSubview(setAndResetButton)
        setAndResetButton.centerX(inView: view,topAnchor: startAndStopButton.bottomAnchor,paddingTop: 32)

    }
}

//MARK: - CountDownViewModelDelegate

extension CountdownViewController : CountDownViewModelDelegate{
    func updateButtonTitle(with title: String) {
        
        startAndStopButton.setTitle(title, for: .normal)
    }
}

//MARK: - UIPickerViewDelegate,UIPickerViewDataSource

extension CountdownViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return 24
        }else{
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return String(format: "%02d", row)
        }else{
            return String(format: "%02d", row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedMinutes = pickerView.selectedRow(inComponent: 0)
        let selectedSeconds = pickerView.selectedRow(inComponent: 1)
        viewModel.currentTime = TimeInterval(selectedMinutes * 60 + selectedSeconds)
        updateCountdownLabel()
    }
}
