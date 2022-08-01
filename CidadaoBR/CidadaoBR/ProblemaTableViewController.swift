//
//  ProblemTableViewController.swift
//  CidadaoBR
//
//  Created by Vinicius on 01/08/22.
//

import UIKit
import CoreData

class ProblemTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<Problema>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblemas()
    }
    
    func loadProblemas(){
        let fetchRequest: NSFetchRequest<Problema> = Problema.fetchRequest()
        let sortDeor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDeor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detalhesProblemaViewController = segue.destination as? DetalhesProblemaViewController,
           let indexPath = tableView.indexPathForSelectedRow{
            detalhesProblemaViewController.problema = fetchedResultsController.object(at: indexPath)
        }
    }
   

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let problema = fetchedResultsController.object(at: indexPath)
            context.delete(problema)
            try? context.save()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProblemaTableViewCell else{
            return UITableViewCell()
        }
        
        let problema = fetchedResultsController.object(at: indexPath)
        cell.configureWith(problema)
        return cell
        
       }
    }

    
extension ProblemTableViewController: NSFetchedResultsControllerDelegate{
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath? ) {
            tableView.reloadData()
        }
}


