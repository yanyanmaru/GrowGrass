

import SwiftUI
import SwiftSoup

@main
struct GrowGrassApp: App {
    @State private var link: String = "何だろうね"
    
    
    var body: some Scene {
        MenuBarExtra {
            Button("水をあげる") {
                fetchData()
            }
            
            .padding()
        } label: {
            
            if link == "1"{
                let image: NSImage = {
                    let ratio = $0.size.height / $0.size.width
                    $0.size.height = 25
                    $0.size.width = 25 / ratio
                    return $0
                }(NSImage(named: "firstnew")!)
                
                Image(nsImage: image)
            }else if link == "2" {
                let image: NSImage = {
                    let ratio = $0.size.height / $0.size.width
                    $0.size.height = 25
                    $0.size.width = 25 / ratio
                    return $0
                }(NSImage(named: "thirdnew")!)
                
                Image(nsImage: image)
            }else if link == "3" {
                let image: NSImage = {
                    let ratio = $0.size.height / $0.size.width
                    $0.size.height = 25
                    $0.size.width = 25 / ratio
                    return $0
                }(NSImage(named: "fourthnew")!)
                
                Image(nsImage: image)
            }else if link == "4" {
                let image: NSImage = {
                    let ratio = $0.size.height / $0.size.width
                    $0.size.height = 25
                    $0.size.width = 25 / ratio
                    return $0
                }(NSImage(named: "fifthnew")!)
                
                Image(nsImage: image)
            }else {
                Image(systemName: "oilcan")
            }
            
        }
        
    }
    func fetchData() {
        let urlString = "https://github.com/users/yanyanmaru/contributions"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let html = String(data: data, encoding: .utf8) ?? ""
                let document = try SwiftSoup.parse(html)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let today = dateFormatter.string(from: Date())
                
                let selector = "td[data-date='\(today)']"
                if let linkElement = try document.select(selector).first() {
                    let link = try linkElement.attr("data-level")
                    DispatchQueue.main.async {
                        self.link = link
                    }
                } else {
                    print("Element not found with selector: \(selector)")
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }.resume()
    }
}

