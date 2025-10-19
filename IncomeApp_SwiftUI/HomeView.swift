//
//  HomeView.swift
//  IncomeApp_SwiftUI
//
//  Created by Mac on 18/10/25.
//

import SwiftUI

struct HomeView: View {
    @State private var transactions: [Transaction] = []
    
    @State private var showAddTransactionView:Bool = false
    @State private var transactiontoEdit:Transaction?
    
  private var expenses :String{
//        var sumExpenses:Double = 0
//        for transaction in transactions {
//            if transaction.type == .expense{
//                sumExpenses += transaction.amount
//            }
//        }
        
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, {$0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$0.00"
    }
    
    private var income :String{
//        var sumImcomes: Double = 0
//        for transaction in transactions {
//            if transaction.type == .income{
//                sumImcomes += transaction.amount
//            }
//        }
        let sumImcomes = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumImcomes as NSNumber) ?? "$ 0.00"
    }
    
    
   private var total:String{
        var total:Double = 0
//        for transaction in transactions {
//            switch transaction.type {
//            case .income:
//                total += transaction.amount
//            case .expense:
//                total -= transaction.amount
//            }
//        }
       let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, {$0 + $1.amount})

       let sumImcomes = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
       total = sumImcomes - sumExpenses
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    fileprivate func FloatingButton() -> some View{
        VStack{
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .foregroundStyle(.white)
                    .frame(width: 70,height: 70)
                    .font(.largeTitle)
            }
            .background(Color("primaryLightGreen"))
            .clipShape(Circle())
            .padding(.bottom,10)
        }
    }
    
    fileprivate func BalanceView() -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("primaryLightGreen"))
            VStack(alignment: .leading,spacing: 8)
            {
                HStack {
                    VStack(alignment: .leading){
                        Text("BALANCE")
                            .foregroundColor(.white)
                            .font(.caption)
                        Text("\(total)")
                            .foregroundColor(.white)
                            .font(.system(size: 42,weight: .light))
                        
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25){
                    VStack(alignment: .leading){
                        Text("Expense")
                            .foregroundStyle(.white)
                            .font(.system(size: 15,weight: .semibold))
                        Text("\(expenses)")
                            .foregroundStyle(.white)
                            .font(.system(size: 15,weight: .regular))
                    }
                    VStack(alignment: .leading){
                        Text("Income")
                            .foregroundStyle(.white)
                            .font(.system(size: 15,weight: .semibold))
                        Text("\(income)")
                            .foregroundStyle(.white)
                            .font(.system(size: 15,weight: .regular))
                    }
                }
                Spacer()
            }.padding(.horizontal)
            
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    BalanceView()
                    List{
                        ForEach(transactions) { transaction in
                            NavigationLink(destination: AddTransactionView(
                                transactions: $transactions,
                                transactionToEdit: transaction)
                            ) {
                                TransactionView(transaction: transaction)
                                    .foregroundColor(.black)
                            }
                            
                        }.onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Income")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                    
                }
            }
            .navigationDestination(for: Transaction.self, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions, transactionToEdit: transactionToEdit)
            })
            
        }
    }
    private func delete(at offsets:IndexSet){
        transactions.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
