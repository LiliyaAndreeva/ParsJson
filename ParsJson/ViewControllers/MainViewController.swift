
import UIKit


enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UIViewController {
    
    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
    
    @IBAction func parsJsonButtonPressed(_ sender: UIButton) {
        fetchParsJson()
    }
}

// MARK: - Extention
extension MainViewController {
    private func fetchParsJson() {
        
        URLSession.shared.dataTask(with: URL(string:"https://random-data-api.com/api/v2/users")!) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error describtion" )
                return
            }
            
            do {
                let parsJson = try JSONDecoder().decode(User.self, from: data)
                print(parsJson)
                self.showAlert(withStatus: .success)
            } catch let error {
                print(error.localizedDescription)
                self.showAlert(withStatus: .failed)
            }
        }.resume()
    }
    
}
