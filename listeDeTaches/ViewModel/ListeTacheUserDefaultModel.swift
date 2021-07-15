//
//  ListeTacheUserDefaultModel.swift
//  listeDeTaches
//
//  Created by Philippe MICHEL on 03/07/2021.
//

import Foundation
import SwiftUI

class ListeTacheUserDefaultModel: ObservableObject {
    @Published var items: [Tache] = []
    let ud = UserDefaults.standard
    let cle = "KEY"
    
    init() {
        guard let donnee = ud.data(forKey: cle) else { return }
        do {
            items = try JSONDecoder().decode([Tache].self, from: donnee)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //synchronisations des donnée sauvegardées
    func synchronisation() {
        do {
            let encoded = try JSONEncoder().encode(items)
            ud.set(encoded, forKey: cle)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Mise à jour de la tâche dans la liste
    func miseAjourTache(tache: Tache) {
        guard let index = items.firstIndex(where: {$0.id == tache.id}) else{ return }
        items[index].statut.toggle()
        synchronisation()
    }
    
    // ajouter une tâche à la liste
    func ajouterTache(string: String) {
        items.append(Tache(nom: string, statut: false))
        synchronisation()
    }
    
    // supprimer une tâche
    func supprimerTache(index: IndexSet) {
        items.remove(atOffsets: index)
        synchronisation()
    }
    
    //supprimer toutes les taches
    func tacheToutSupprimer() {
        items.removeAll()
        synchronisation()
    }
    
}
