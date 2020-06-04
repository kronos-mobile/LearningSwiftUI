import SwiftUI
import Combine

struct CoinList: View {
    private let viewModel = CoinListViewModel()
    var body: some View {
        Text("Hello, World!").onAppear {
            self.viewModel.fetchCoins()
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
    }
}

class CoinListViewModel: ObservableObject {
    private let cryptoService = CryptoService()
    @Published var coinViewModels = [CoinViewModel]()
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            
        }, receiveValue: { crytoContainer in
            self.coinViewModels = crytoContainer.data.coins.map { CoinViewModel($0) }
            print(self.coinViewModels)
        })
    }
    
}

struct CoinViewModel: Hashable {
    private let coin: Coin
    
    var name: String {
        coin.name
    }
    
    var formattedPrice: String {
        // do some formatting
        coin.price
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
}
