import UIKit

class Modulo1ViewController: ModuloViewController {

    @IBOutlet var botoes: [UIButton]!
    @IBOutlet weak var labelPergunta: UILabel!
    
    let perguntas = [
        ("Como se define uma constante de nome \"email\", tipo String e valor \"meu@email.com\"",
            ["var email:String = \"meu@email.com\"",
                "let email = \"meu@email.com\"",
                "let email:String = meu@email.com",
                "var email = \"meu@email.com\""]),
        
        ("Qual a sintaxe de um operador ternário?",
            ["var numero:Int = (condicao == true) ? 10 : 20",
                "var numero:Int = [condicao == true] ? 10 : 20",
                "var numero:Int = {condicao == true} ? 10 : 20",
                "var numero:Int = (condicao == true) : 10 ? 20"]),
        
        ("var variavel = (0, 50) -> Esta variável é de que tipo?",
            ["Tupla",
                "String",
                "Closure",
                "Dicionário"]),
        
        ("Qual comando você usaria para varrer um Array?",
            ["for item in array {}",
                "if (array.count) {}",
                "valor = (array[indice] == 0) ? 0 : 1",
                "split(array) {$0 == $1}"]),
        
        ("Qual palavra reservada você utilizaria para criar um protocolo?",
            ["protocol",
                "class",
                "delegate",
                "subscript"]),
        
        ("Qual o nome do operador %",
            ["Módulo",
                "Divisão",
                "Exponencial",
                "Quociente"]),
        
        ("Como se declara uma função?",
            ["func nomedafuncao (parametro: Tipo) -> TipoRetorno {}",
                "func nomedafuncao (parametro, Tipo) []",
                "var nomedafuncao []",
                "nomedafuncao {()-()}"])
    ]
    
    
    override func viewDidLoad() {
        tituloModulo = "Módulo 101: Linguagem"
        totalPerguntas = perguntas.count
        tempo = 15.0
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func iniciarQuiz() {
        print("iniciarQuiz do Módulo 1")
        indiceAtual = pegarQuiz()
        labelPergunta.text = perguntas[indiceAtual].0
        var respostas = perguntas[indiceAtual].1
        for (var i:Int = 0; i < 4; i++) {
            botoes[i].setTitle(respostas.removeAtIndex(gerarNumeroAleatorio(respostas.count)), forState: UIControlState.Normal)
        }
    }

    @IBAction func responder(sender: UIButton) {
        perguntasRespondidas++
        if (sender.titleForState(UIControlState.Normal)! == perguntas[indiceAtual].1[0]) {
            acertos++
        }
        iniciarQuiz()
    }
    
}





