//
//  RickyMortyViewModel.swift
//  RickAndMortyWithoutSB
//
//  Created by mert Kanak on 8.12.2022.
//

import Foundation

protocol IRickyMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickyMortyCharacters: [Result] { get set }
    var rickyMortyService: IRickyMortyService { get }
    
    var rickyMortyOutput: RickyMortyOutput? { get }
    
    func setDelegate(output: RickyMortyOutput)

}


final class RickyMortyViewModel: IRickyMortyViewModel{
   
    func setDelegate(output: RickyMortyOutput) {
        rickyMortyOutput = output
    }
 
    
    var rickyMortyOutput: RickyMortyOutput?
    
  
    var rickyMortyCharacters: [Result] = []
    private var isLoading = false 
    var rickyMortyService: IRickyMortyService = RickyMortyService()
    
    init(){
    rickyMortyService = RickyMortyService()
    }
    
    
    func fetchItems() {
        changeLoading()
        rickyMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.rickyMortyCharacters ?? [])
            
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
    
}
