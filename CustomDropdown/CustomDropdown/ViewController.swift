//
//  ViewController.swift
//  CustomDropdown
//
//  Created by Dang Duy Cuong on 9/25/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

enum DropDownFlag {
    case vietnam
    case thailand
    case laos
    case cambodia
    
    case china
    case north_korea
    case ussr
    case canada
    
    case india
    case usa
    
    static let all = [vietnam, thailand, laos, cambodia, china, ussr, ussr, canada, india, usa]
    
    var image: UIImage? {
        get {
            switch self {
            case .vietnam:
                return #imageLiteral(resourceName: "2000px-Flag_of_Vietnam.svg")
            case .thailand:
                return #imageLiteral(resourceName: "1200px-Flag_of_Thailand_(non-standard_colours).svg")
            case .laos:
                return #imageLiteral(resourceName: "1200px-Flag_of_Laos.svg")
            case .cambodia:
                return #imageLiteral(resourceName: "255px-Flag_of_Cambodia.svg")
            case .china:
                return #imageLiteral(resourceName: "1280px-Flag_of_the_People's_Republic_of_China.svg")
            case .north_korea:
                return #imageLiteral(resourceName: "2880px-Flag_of_North_Korea.svg")
            case .ussr:
                return #imageLiteral(resourceName: "s-l300")
            case .canada:
                return #imageLiteral(resourceName: "flag-canada-260nw-94948876")
            case .india:
                return #imageLiteral(resourceName: "510px-Flag_of_India.svg")
            case .usa:
                return #imageLiteral(resourceName: "2560px-Flag_of_the_United_States.svg")
            }
        }
    }
    
    var text: String {
        get {
            switch self {
            default:
                return "\(self)"
            }
        }
    }
    
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var flagTextField: UITextField!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    var listDevice = [ListDeviceModel]()
    var suggestDevice = [ListDeviceModel]()
    let dropdown = DropDown()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        flagTextField.delegate = self
        getListDevice()
    }
    
    func getListDevice() {
        guard let path = Bundle.main.path(forResource: "ListIphone", ofType: "plist") else {return}
        let settingsURL = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: settingsURL)
            let decoder = PropertyListDecoder()
            listDevice = try decoder.decode([ListDeviceModel].self, from: data)
        } catch {
            // Handle error
            print(error)
        }
    }

    func filterDevice() {
        if flagTextField.text == "" {
            suggestDevice = listDevice
        } else {
            suggestDevice = listDevice.filter { (data: ListDeviceModel) in
                if let device = data.iPhone, let text = flagTextField.text {
                    if device.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
    }

    func selectFlag() {
//        dropdown.dataSource = DropDownFlag.all.map { $0.text }
        dropdown.dataSource = suggestDevice.map { $0.iPhone ?? "" }
        dropdown.cellNib = UINib(nibName: "CustomCell", bundle: nil)
        dropdown.anchorView = flagTextField
        dropdown.direction = .bottom
        dropdown.bottomOffset = CGPoint(x: 0, y: flagTextField.bounds.size.height)
        dropdown.customCellConfiguration = { (index, string, cell) -> Void in
            if let cell = cell as? CustomCell {
//                cell.flagImageView.image = DropDownFlag.all[index].image
            }
        }
        dropdown.selectionAction = { (index, item) in
            self.flagTextField.text = item
//            self.flagImageView.image = DropDownFlag.all[index].image
        }
        dropdown.show()
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterDevice()
        selectFlag()
//        textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filterDevice()
        selectFlag()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dropdown.hide()
        return true
    }
}

