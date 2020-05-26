//
//  WinnerViewController.swift
//  Raffle
//
//  Created by StarWen on 26/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {
    var winnersDetailFromPreviousPage: String = ""
    
    
    @IBOutlet var winnerInforLabal: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerInforLabal.text = winnersDetailFromPreviousPage

        // Do any additional setup after loading the view.
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
