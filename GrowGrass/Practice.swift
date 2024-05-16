import SwiftUI
import SwiftSoup

struct PracticeView: View {
    @State private var title: String = "Loading..."
    @State private var links: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .padding()

                List(links, id: \.self) { link in
                    Text(link)
                }
                .onAppear {
                    fetchData()
                }
            }
            .navigationTitle("Web Scraper")
        }
    }

    func fetchData() {
        let urlString = "https://github.com/users/yanyanmaru/contributions"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let html = String(data: data, encoding: .utf8) ?? ""
                let document = try SwiftSoup.parse(html)

                // Fetch title
                let pageTitle = try document.title()
                DispatchQueue.main.async {
                    self.title = pageTitle
                }

                // Fetch links
                let linkElements = try document.select("td[data-date=2024-05-16]")
                var fetchedLinks: [String] = []
                for element in linkElements {
                    let link = try element.attr("data-level")
                    fetchedLinks.append(link)
                }
                DispatchQueue.main.async {
                    self.links = fetchedLinks
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    PracticeView()
}


