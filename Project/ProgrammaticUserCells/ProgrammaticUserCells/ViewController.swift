import UIKit

class ViewController: UIViewController {
    
    var user = [User](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout:
            layout)
        collection.dataSource = self
        collection.delegate = self
        let nib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "userCell")
        //collection.backgroundColor = .white
        return collection
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //collectionView.setCollectionViewLayout(layout, animated: true)
        self.view.addSubview(collectionView)
        //self.view.addSubview(switchButton)
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        UsersFetchingService.manager.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userFromOnline):
                    DispatchQueue.main.async {
                    self.user = userFromOnline
                    }
                }
            }
        }
    }
    
    
    
}




extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let person = user[indexPath.row]
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCollectionViewCell else {return UICollectionViewCell()}
        cell.message.text = "\(person.name.title).\(person.name.first) \(person.name.last)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = user[indexPath.row]
        let dVC = DetailViewController()
        dVC.stuff = person
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    
}


