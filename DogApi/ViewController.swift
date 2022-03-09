//
//  ViewController.swift
//  DogApi
//
//  Created by Francisco Escobar on 2022-02-11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogName: UILabel!
    
    var dogList = [Dog]()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
        DogAPIHelper.fetch { dogList in self.dogName.text = dogList[0].name}
    }

    
}
