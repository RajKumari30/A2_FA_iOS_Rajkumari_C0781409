//
//  ProductDetailVC.swift
//  A2_FA_iOS_Rajkumari_C0781409
//
//  Created by Rajkumari on 31/01/21.
//  Copyright © 2021 RajKumari. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var lbProdProce: UILabel!
    @IBOutlet weak var lbProdProvider: UILabel!
    @IBOutlet weak var lbProdDesc: UILabel!
    @IBOutlet weak var lbProdName: UILabel!
    @IBOutlet weak var lbProductID: UILabel!
    
    var prod : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prod.prodName ?? ""
        
        lbProdName.text = prod.prodName ?? ""
        lbProductID.text = "\(prod.prodID)"
        lbProdDesc.text = prod.prodDesc ?? ""
        lbProdProvider.text = prod.prodProvider ?? ""
        lbProdProce.text = "\(prod.prodPrice)"

        // Do any additional setup after loading the view.
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
