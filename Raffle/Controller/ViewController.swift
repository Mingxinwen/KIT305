//
//  ViewController.swift
//  Raffle
//
//  Created by StarWen on 13/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")

    override func viewDidLoad() {
            super.viewDidLoad()
        database.insert(raffle:Raffle(name:"Raffle A", price:10, description: "noteA"))
                
        database.insert(raffle:Raffle(name:"Raffle B", price:8, description: "noteB"))
            
    //        print(database.selectAllMovies())
            print(database.selectRafflesBy(id:1) ?? "Raffle not found")

        database.insertTicket(ticket:Ticket( ID: 1, Customer_name:"Adams Smitch"))
        database.insertTicket(ticket:Ticket(ID: 2, Customer_name:"Adams Smitch"))
        
         // print(database.selectTicketsBy(id:1) ?? "Raffle not found")
        }


}
