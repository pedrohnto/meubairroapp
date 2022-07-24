//
//  ReportsTableViewController.swift
//  MeuBairroApp
//
//  Created by pedohn13@gmail.com on 7/24/22.
//

import UIKit
import CoreData

class ReportsTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Report>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReports()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reportViewController = segue.destination  as? ReportViewController,
           let row = tableView.indexPathForSelectedRow {
            reportViewController.report = fetchedResultsController.object(at: row)
        }
            
    }
    
    func loadReports() {
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
        let sortDescriptorDate = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorDate, sortDescriptorName]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/YY"
        //Optei por nao criar uma controller para a celula devido a simplicidade da celula solicitada na documentacao
        content.text = fetchedResultsController.object(at: indexPath).name
        if let reportDate = fetchedResultsController.object(at: indexPath).date {
            content.secondaryText = dateFormater.string(from: reportDate)
        }
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let report = fetchedResultsController.object(at: indexPath)
            context.delete(report)
            try? context.save()
        }
    }
}

extension ReportsTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        tableView.reloadData()
    }
}
