//
//  MAinTabbedView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct MainTabbedView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var viewModel: MainTabbedViewModel

    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $viewModel.selectedTab) {
                LibraryView(viewModel: .init(booksProvider: viewModel.booksProvider,
                                             userProvider: viewModel.userProvider,
                                             authenticationProvider: viewModel.authenticationProvider))
                    .tag(0)

                MyBooksView()
                    .tag(1)

                StatisticsView(viewModel: StatisticsViewModel())
                    .tag(2)

                ProfileView()
                    .tag(3)
            }

            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            viewModel.selectedTab = item.rawValue
                        } label: {
                            customTabItem(imageName: item.iconName,
                                          title: item.title,
                                          isActive: (viewModel.selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 60)
            .background(.purple.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
            .offset(y: 15)
        }
    }
}

extension MainTabbedView{
    func customTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
                    .fixedSize()
            }
            Spacer()
        }
        .frame(height: 50)
        .background(isActive ? .purple.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}

struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView(viewModel: .init(authenticationProvider: AuthenticationRepositoryMock(),
                                        userProvider: UserRepositoryMock(),
                                        booksProvider: BooksRepositoryMock()))
    }
}
