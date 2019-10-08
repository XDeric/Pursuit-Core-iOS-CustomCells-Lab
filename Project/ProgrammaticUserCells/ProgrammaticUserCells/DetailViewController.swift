//
//  DetailViewController.swift
//  ProgrammaticUserCells
//
//  Created by EricM on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var stuff: User?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "userCell2")
        return table
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        constraint()
        // Do any additional setup after loading the view.
    }
    
    func constraint(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "userCell2", for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        cell.textLabel?.text = stuff?.name.first
        cell.detailTextLabel?.text = stuff?.location.city
        
        return cell
    }
    
    
}
