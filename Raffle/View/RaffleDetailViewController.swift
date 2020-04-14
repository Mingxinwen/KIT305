//
//  RaffleDetailViewController.swift
//  Raffle
//
//  Created by StarWen on 14/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class RaffleDetailViewController: UIViewController {
    var raffle : Raffle?

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let displayRaffle = raffle
        {
            nameLabel.text = displayRaffle.name
            priceLable.text = String(displayRaffle.price)
            descriptionLable.text = displayRaffle.description
    } }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
