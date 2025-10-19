//
//  AddTransactionView.swift
//  IncomeApp_SwiftUI
//
//  Created by Mac on 19/10/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = 0.0
    @State private var selectedTransactionType:TransactionType = .expense
    @State private var transactionTitle:String = ""
    
    @State private var alerttitle:String = ""
    @State private var alertMessage:String = ""
    @State private var showAlert:Bool = false
    @Binding var transactions: [Transaction]
    var transactionToEdit: Transaction?
    @Environment(\.dismiss) var dissmiss
    
    var numberFormatter:NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack{
            TextField("0.0", value: $amount, formatter: numberFormatter)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(height: 0.5)
                .padding(.horizontal,30)
                .font(.system(size: 60,weight: .thin))
            Picker("Choose type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.top)
                .padding(.horizontal,30)
            Button {
                
                guard transactionTitle.count >= 2 else {
                    alerttitle = "Invalid Title"
                    alertMessage = "Please enter title more than 2 characters"
                    showAlert = true
                    return
                }
                
                let newTransaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                if let transactionToEdit = transactionToEdit{
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit)else
                    {
                        alerttitle = "Something went wrong"
                        alertMessage = "Can not update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = newTransaction
                }else{
                    transactions.append(newTransaction)
                    
                }
                // MARK: Alternate to find index if not hashable
                //                let index = transactions.firstIndex { transaction in
                //                    self.transactionToEdit?.id == transaction.id
                //                }
                
                dissmiss()
            } label: {
                Text(transactionToEdit == nil ?  "Create" : "Update")
                    .font(.system(size: 15,weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color("primaryLightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            .padding(.horizontal,30)
            .padding(.top)
            
            Spacer()
        }
        .onAppear(perform: {
            if let transactiotoEdit = transactionToEdit{
                amount = transactiotoEdit.amount
                selectedTransactionType = transactiotoEdit.type
                transactionTitle = transactiotoEdit.title
            }
        })
        .padding(.top)
        .alert(alerttitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Ok")
            }
            
        } message: {
            Text(alertMessage)
        }
        
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(transactions: .constant([]))
    }
}
