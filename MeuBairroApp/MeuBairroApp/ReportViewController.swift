//
//  ReportViewController.swift
//  MeuBairroApp
//
//  Created by pedohn13@gmail.com 7/24/22.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewReport: UIImageView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var textViewDetail: UITextView!
    
    var report: Report?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadReport()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reportFormViewController = segue.destination  as? ReportFormViewController {
            reportFormViewController.report = self.report
        }
    }
    
    func loadReport() {
        if let report = report {
            labelName.text = report.name
            labelLocation.text = report.location
            textViewDetail.text = report.detail
            
            if let image = report.image {
                imageViewReport.image = UIImage(data: image)
            }
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "E, d MMM YYYY, HH:mm:ss"
            if let reportDate = report.date {
                labelDate.text = dateFormater.string(from: reportDate)
            }
        }
    }

}
