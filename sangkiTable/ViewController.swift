//
//  ViewController.swift
//  sangkiTable
//
//  Created by キム・サンギ on 2020/11/11.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //위에 뒤에있는 두 개는 무언가를 구현해야 한다 - 밑에 두 함수
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    // ? - 값이 비어있을수 있다
    var newsData : Array<Dictionary<String,Any>>?
    
    //1. http통신 방법 - urlsession
    //2. JSON 데이터 형태
    //3. 테이블뷰의 데이터 매칭 <-- 통보! 화면을 그리기
    //중요!! 네트워크 통신의 기본 원칙 : 네트워크 통신을 하게되면 background에서 돈다. ui는 main에서 그린다
    
    func getNews(){
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&category=business&apiKey=95cb07b08daf4adab66d0506d90fed2d")!) { (data, reponse, error) in
            
            if let dataJson = data {
                
                //JSON Parsing - JSON형태로 바꿔준다
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    let articles = json["articles"] as! Array<Dictionary<String,Any>>
                    
                    //바깥에 있는 녀석이라 self를 붙인다
                    self.newsData = articles
                    
                    //메인에서 화면을 그려라
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                    
//                    for (idx, value) in articles.enumerated() {
//                        if let v = value as? Dictionary<String,Any>{
//                            print("\(v["title"])")
//                        }
//                    }
                    //print(json)
                }catch{}
                
            }
        }
        
        task.resume()
    }
    
    
    //데이터 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //만약에 newsData가 값이 들어있으면
        if let news = newsData{
            return news.count
        }else{
            return 0
        }
        
    }
    
    //데이터가 무엇?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //반복 10번?
        //셀을 만드는 방법은 두 가지
        //1번 방법 - 임의의 셀 만들기
        
        //특정한 셀을 효율적으로 반복해서 사용한다
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCelType1")
        
        //2번 방법 - 스토리보드 + id
        //as? as!  as=부모와 자식간의 친자확인
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        let idx = indexPath.row
            
        //셀에 무엇을 보여준다
        //cell.textLabel?.text = "\(indexPath.row)"
        
        if let news = newsData {
            
            let row = news[idx]
            
            if let v = row as? Dictionary<String,Any>{
                if let title = v["title"] as? String{
                    cell.LabelText.text = title
                }
            }
            
        }
        
        
        return cell
    }
    
    //1.tableview delegate 클릭시 함수 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click\(indexPath.row)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        
        if let news = newsData {
            let row = news[indexPath.row]
            
            if let v = row as? Dictionary<String,Any>{
                if let imageUrl = v["urlToImage"] as? String{
                    controller.imageUrl = imageUrl
                }
                if let desc = v["description"] as? String{
                    controller.desc = desc
                }
                
                if let u = v["url"] as? String{
                    controller.allUrl = u
                }
            }
        }
        
        //이동! - 수동
        //showDetailViewController(controller, sender: nil)
    }
    
    //2.storyboad (segue) : 부모(가나다)-자식(가나다)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,"NewsDetail" == id{
            if let controller = segue.destination as? NewsDetailController{
                
                if let news = newsData {
                    if let indexPath = TableViewMain.indexPathForSelectedRow{
                        let row = news[indexPath.row]
                        
                        if let v = row as? Dictionary<String,Any>{
                            if let imageUrl = v["urlToImage"] as? String{
                                controller.imageUrl = imageUrl
                            }
                            if let desc = v["description"] as? String{
                                controller.desc = desc
                            }
                            if let u = v["url"] as? String{
                                controller.allUrl = u
                            }
                        }
                    }
                    

                }
            }
        }
        //이동! - 자동
    }
    
    
    //1. 디테일(상세)화면 만들기 - NewsDetailController
    //2. 값을 보내기 2가지
    //   1.tableview delegate / 2. storyboard (segue)
    //3. 화면 이동 !! (이동하기전에 값을 미리 셋팅해야한다!!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //셀프가 의미하는거는 클래스 안의 func을 의미
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }

    
    //tableView 테이블로 된 뷰 - 여려개의 행이 모여있는 목록 뷰(화면)
    //목적 : 정갈하게 보여주려고 ex)전화번호부
    
    //1. 데이터가 무엇? - ex)전화번호부 목록
    //2. 데이터 몇개? - ex)100개
    //3. (옵션) 데이터 행 눌렀다 - ex)전화번호 클릭
    
    
}

