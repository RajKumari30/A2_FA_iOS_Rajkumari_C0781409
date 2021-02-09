//
//  ViewController.swift
//  A2_FA_iOS_Rajkumari_C0781409
//
//  Created by Rajkumari on 31/01/21.
//  Copyright © 2021 RajKumari. All rights reserved.
//


// My final assignment
import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var search: UISearchBar!
    var prod: [Product] = []
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        retriveData()

    }
    func retriveData() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        
          let req: NSFetchRequest<Product> = Product.fetchRequest()
          
        if search.text?.count ?? 0 > 0{
                req.predicate = NSPredicate(format: "prodName contains[cd] %@ OR prodDesc contains[cd] %@", search.text ?? "", search.text ?? "")
        }


        do {
          prod = try managedContext.fetch(req)
          self.tblView.reloadData()
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.retriveData()
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return prod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = prod[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.textLabel?.text = product.prodName ?? ""
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = prod[indexPath.row]
        let vc : ProductDetailVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as! ProductDetailVC
        vc.prod = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
