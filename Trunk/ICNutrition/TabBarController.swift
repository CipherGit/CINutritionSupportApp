//
//  TabBarController.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Patient Name"
        let image = UIImage(named: "Back-24.png")
        
//        let leftButton = UIBarButtonItem(title: "Chiudi", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBack))
        
        //let leftButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: "goBack")
        
        //leftButton.customView = view
        
        let button = UIButton(type: UIButtonType.system)
        button.setImage(UIImage(named: "Back-24.png"), for: UIControlState.normal)
        button.setTitle("List", for: UIControlState.normal)
        button.sizeToFit()
        button.target(forAction: #selector(goBack), withSender: self)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
//        leftButton.setTitle("Name", )
//        leftButton.title = "Name"
//
//        let navigationItem = self.navigationItem
//        navigationItem.titleView = UIImageView(image: UIImage(named: "heart.png"))
//        navigationItem.leftBarButtonItem = leftButton
        
//        self.navigationItem = navigationItem
        
//        self.navigationItem.leftBarButtonItem = leftButton
//        image = image?.renderingMode(UIImageRenderingMode.alwaysOriginal)
        /*
                 self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.plain, target: self, action: "goBack")
        
        */
        // Do any additional setup after loading the view.
    }
    
    func goBack() {
        
        self.navigationController?.dismiss(animated: true, completion: {})
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
