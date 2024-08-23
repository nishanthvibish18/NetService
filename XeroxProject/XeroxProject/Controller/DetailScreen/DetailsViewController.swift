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
        
        self.apiCall()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
 
    private func apiCall(){
        self.detailViewModel.currentIpApi { [weak self] result in
            switch result {
            case .success(let success):
                self?.getiPDetails(ipAddress: success.ip ?? "")
            case .failure(let failure):
                self?.alertController(message: failure.localizationError)
            }
        }
    }
    private func getiPDetails(ipAddress: String){
        self.detailViewModel.getIpDetails(ipAddress: ipAddress) { [weak self] result in
            switch result {
            case .success(let success):                
                self?.updateData(details: success)
            case .failure(let failure):
                self?.alertController(message: failure.localizationError)
            }
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
