//
//  DashboardViewController.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!

    let dashboardViewmodel: DashboardViewModel! = DashboardViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.sharedInstance.startMonitor()
        self.loadData()
    }
   
    private func loadData(){
        self.dashboardViewmodel.delegate = self
        self.dashboardViewmodel.fetchData()
        if self.dashboardViewmodel.discoveredDevices.count == 0{
            self.dashboardViewmodel.startMonitor()
        }
    }
    
    
    
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        
        LoginViewModel().logout()
        
    }
    
    
}

extension DashboardViewController: DiscoverNetworkStauts{
    func updateStatusView() {
        
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dashboardViewmodel.discoveredDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardTableViewCell", for: indexPath) as? dashboardTableViewCell else{
            return UITableViewCell.init()
        }
        
        let detail = self.dashboardViewmodel.discoveredDevices[indexPath.row]
        
        cell.deviceIpLabel.text = detail.ipAddress
        cell.deviceNameLabel.text = detail.deviceName
        cell.devicestatusLabel.text = detail.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


