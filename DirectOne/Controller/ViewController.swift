//
//  ViewController.swift
//  DirectOne
//
//  Created by Robert on 15.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import DropDown


class ViewController: UIViewController, PlaceSearchDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    
    var placeSearchResult: [MKLocalSearchCompletion] = []
    let placeSearcher = PlaceSearch()
    let dropDown = DropDown()
    var distance = Double()
    
    var coordinates : [CLLocationCoordinate2D?] = [] {
        didSet{
            if coordinates.count == 2 {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.calculateDistance()
                }}}
    }
    
    var currentUnit = UnitConverter.unitState.meter {
        didSet{
            DispatchQueue.main.async {
                self.label.text = "Distance: \(UnitConverter.allUnits[self.currentUnit.hashValue](self.distance).stringValue)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTap))
        label.isHidden = true
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        dropDown.selectionAction = selectedRow
        placeSearcher.delegate = self
    }
    
    
    @IBAction func getDistance(_ sender: UIButton) {
        if let textFrom = self.fromField.text, let textTo = self.toField.text {
            DispatchQueue.global(qos: .userInitiated).async {
                self.coordinates = []
                self.placeSearcher.getCoordiantes(for: textFrom, completionHandler: handler(data:error:))
                self.placeSearcher.getCoordiantes(for: textTo, completionHandler: handler(data:error:))
            }
        }
        
        func handler(data:CLLocationCoordinate2D?, error:Error?) {
            if let _ = error {
                DispatchQueue.main.async {
                    self.label.text = "Error! Try later"
                }
            } else {
                self.coordinates.append(data)
            }
        }
    }
    
    func calculateDistance() {
        if let firstCoordinate = coordinates.first, let secondCoordinate = coordinates.last {
            self.distance = getDistanceBetween(from: firstCoordinate, to: secondCoordinate)
            DispatchQueue.main.async {
                self.currentUnit = .meter
                self.label.isHidden = false
            }
        }
    }
    
    private func setDropDownContext(for sender: UITextField) {
        if sender.accessibilityIdentifier == "from" {
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .bottom
        }
        else if sender.accessibilityIdentifier == "to" {
            dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .top
        }
    }
    
    @IBAction func fieldTypeCathcer(_ sender: UITextField) {
        if let term = sender.text {
            placeSearcher.findPlace(term)
            dropDown.anchorView = sender
            setDropDownContext(for: sender)
            self.updateDropDown(dropDown)
        }
    }
    
    func updateDropDown(_ dropDown: DropDown) {
        var dropdownSource = [String]()
        placeSearchResult.forEach {
            dropdownSource.append($0.title)
        }
        dropDown.dataSource = dropdownSource
        dropDown.show()
        
    }
    
    func selectedRow(index: Int, item: String) {
        if let field = dropDown.anchorView as? UITextField {
            field.text = item
        }
    }
    
    @objc func labelTap(sender : UITapGestureRecognizer) {
        switch currentUnit {
        case .meter:
            currentUnit = .kilmeter
        case .kilmeter:
            currentUnit = .feet
        case .feet:
            currentUnit = .mile
        default:
            currentUnit = .meter
        }
    }
}

