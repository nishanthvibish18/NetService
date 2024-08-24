//
//  DetailsViewController.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    
    let detailViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.sharedInstance.startMonitor()
        
        self.activityIndicator.startAnimating()
        
        Task{
            await self.apiCall()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
 
    private func apiCall() async{
        do{
            let response = try await self.detailViewModel.currentIpAPI()
            await self.getiPDetails(ipAddress: response?.ip ?? "")
        }
        catch let error{
            self.alertController(message: error.localizedDescription)
        }
    }
    
    
    private func getiPDetails(ipAddress: String) async{
        do{
            let result = try await self.detailViewModel.getIpDetails(ipAddress: ipAddress)
            if let result = result {
                self.updateData(details: result)
            }
        }
        catch let error{
            self.alertController(message: error.localizedDescription)

        }
    }
    
    
    func alertController(message: String){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            let uialerControlelr = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            uialerControlelr.addAction(UIAlertAction(title: "Done", style: .default))
            self.present(uialerControlelr, animated: true, completion: nil)
        }
    }
    
    
    func updateData(details: IpdetailsModel){
    
        DispatchQueue.main.async {
            self.timeZoneLabel.text = "Time Zone : \(details.timezone ?? "")"
            self.ipAddressLabel.text = "iP Address :  \(details.ip ?? "")"
            self.regionLabel.text = "Region : \(details.region ?? "")"
            self.postalCodeLabel.text = "Postal Code : \(details.postal ?? "")"
            self.countryLabel.text = "Country : \(details.country ?? "")"
            self.hostNameLabel.text = "Host Name : \(details.hostname ?? "")"
            self.cityLabel.text = "City : \(details.city ?? "")"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true

        }
        
    }


}
