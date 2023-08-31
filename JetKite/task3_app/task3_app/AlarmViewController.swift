//
//  ViewController.swift
//  task3_app
//
//  Created by Murat on 29.08.2023.
//

import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
    
    //MARK: - Properties
    
    private let timePicker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var alarmButton : UIButton = {
       
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setDimensions(height: 80, width: 130)
        button.setTitle("Set Alarm", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSetAlarm), for: .touchUpInside)
        return button
        
    }()
    
    var hours = Array<Int>(0...23)
    
    var minutes = Array<Int>(0...59)
    
    private var viewModel = AlarmViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: - Actions
    
    @objc func handleSetAlarm(){
        viewModel.setAlarm(hour: viewModel.selectedHour, minute: viewModel.selectedMinute) { success, error in
            
            if success {
                DispatchQueue.main.async { [self] in
                    self.showMessage(withTitle: "Alarm set", message: "\(viewModel.selectedHour):\(viewModel.selectedMinute)", vc: self)
                }
            }
            
            if error != nil{
                DispatchQueue.main.async {
                    self.showMessage(withTitle: "Error", message: "\(String(describing: error))", vc: self)
                }
            }
            
        }
       
    }
    
    //MARK: - Helpers

    func configureUI(){
        
        view.backgroundColor = .white
        
        timePicker.delegate = self
        timePicker.dataSource = self
        
        
        view.addSubview(timePicker)
        timePicker.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        view.addSubview(alarmButton)
        alarmButton.centerX(inView: view,topAnchor: timePicker.bottomAnchor,paddingTop: 32)
        
    }
}

//MARK: - UIPickerViewDelegate,UIPickerViewDataSource

extension AlarmViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return component == 0 ? hours.count : minutes.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let stringHours = String(format: "%02d", row)
        let stringMinutes = String(format: "%02d", row)
        
        if component == 0 {
            return stringHours
        }else{
            return stringMinutes
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if component == 0 {
               viewModel.selectedHour = hours[row]
           } else {
               viewModel.selectedMinute = minutes[row]
           }
       }
}

