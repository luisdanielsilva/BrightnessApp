import SwiftUI

@main
struct BrightnessApp: App {
    // Guarda o estado atual da percentagem do ecrã
    @AppStorage("currentBrightness") var currentBrightness: Double = 1.0
    
    // O valor máximo estimado de nits do ecrã (Ajustável)
    let maxNits: Float = 500.0

    var body: some Scene {
        MenuBarExtra {
            // Seção de controlo de brilho com valores em % e nits
            Button("25% de Brilho (\(Int(0.25 * maxNits)) nits)") { setLevel(0.25) }
            Button("50% de Brilho (\(Int(0.50 * maxNits)) nits)") { setLevel(0.50) }
            Button("75% de Brilho (\(Int(0.75 * maxNits)) nits)") { setLevel(0.75) }
            Button("100% de Brilho (\(Int(maxNits)) nits)") { setLevel(1.0) }
            
            Divider()
            
            // Botão Sair com rotina especial de "Restauro" para 25%
            Button("Sair") {
                BrightnessManager.setBrightness(level: 0.25)
                NSApplication.shared.terminate(nil)
            }
        } label: {
            // O ícone dinâmico:
            // Fica um Sol Amarelo completo nos 100%, senão um sol simples padrão
            if currentBrightness >= 1.0 {
                Image(systemName: "sun.max.fill")
                    .symbolRenderingMode(.multicolor)
            } else if currentBrightness >= 0.75 {
                Image(systemName: "sun.max")
            } else if currentBrightness >= 0.50 {
                Image(systemName: "sun.min.fill")
            } else {
                Image(systemName: "sun.min")
            }
        }
    }
    
    // Pequena função para mudar o brilho e atualizar o ícone
    func setLevel(_ level: Double) {
        currentBrightness = level
        BrightnessManager.setBrightness(level: Float(level))
    }
}
