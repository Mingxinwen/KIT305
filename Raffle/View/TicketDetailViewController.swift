//
//  TicketDetailViewController.swift
//  Raffle
//
//  Created by Vinh Nguyen on 20/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class TicketDetailViewController: UIViewController {
    var ticket : Ticket?
    
    @IBOutlet var TicketNumberLabel: UILabel!
    
    
    @IBOutlet var TicketNumberLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let displayTicket = ticket
               {
                TicketNumberLabel.text = displayTicket.Customer_name
                TicketNumberLable.text = String(displayTicket.ID)
                 
           }
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
