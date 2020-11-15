//
//  NewsDetailController.swift
//  sangkiTable
//
//  Created by キム・サンギ on 2020/11/15.
//

import UIKit

class NewsDetailController : UIViewController{
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    @IBOutlet weak var OpenLink: UIButton!
    
    //밑의 값들을 받아야한다
    //1.이미지 url
    var imageUrl : String?
    //2.Description

    var desc : String?
    //3. 기사url
    var allUrl : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //값이 있으면?
        if let img = imageUrl{
            //이미지 가져와서 뿌린다
            //이미지를 보여주는 방법 : Data
            if let data = try? Data(contentsOf: URL(string: img)!){
                
                //Main Thread
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let d = desc{
            //본문 보여준다
            self.LabelMain.text = d
        }
 
    }
    
    @IBAction func openLink(_ sender: Any) {
        if let url = allUrl {
            let dest = URL (string: url)!
            UIApplication.shared.open (dest)
        }

    }
    
}
