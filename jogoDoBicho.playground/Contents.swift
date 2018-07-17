var milhar = 5678
var dados = Array(toString(milhar))
var novoDados = String(dados[2...3]).toInt()

//let digito1 = dados[2]
//let digito2 = dados[3]

var icone = ""

var bicho = ""

var grupo : Int = 0

let grupoBichos = [
    ("Avestruz",1,4,"🐦",1),
    ("Aguia",5,8,"🐥",2),
    ("Burro",9,12,"🐃",3),
    ("Borboleta",13,16,"🐞",4),
    ("Cachorro",17,20,"🐺",5),
    ("Cabra",21,24,"🐐",6),
    ("Carneiro",25,28,"🐑",7),
    ("Camelo",29,32,"🐫",8),
    ("Cobra",33,36,"🐍",9),
    ("Coelho",37,40,"🐇",10),
    ("Cavalo",41,44,"🐴",11),
    ("Elefante",45,48,"🐘",12),
    ("Galo",49,52,"🐓",13),
    ("Gato",53,56,"🐱",14),
    ("Jacaré",57,60,"🐊",15),
    ("Leão",61,64,"🐆",16),
    ("Macaco",65,68,"🐒",17),
    ("Porco",69,72,"🐖",18),
    ("Pavão",73,76,"🍁",19),
    ("Peru",77,80,"🐧",20),
    ("Touro",81,84,"🐂",21),
    ("Tigre",85,88,"🐅",22),
    ("Urso",89,92,"🐼",23),
    ("Veado",93,96,"🌺",24),
    ("Vaca",97,00,"🐄",25)
]

for (animal,pri_num,seg_num,img,grupoAnimal) in grupoBichos {

    if pri_num <= novoDados && seg_num >= novoDados {
    
        bicho = animal
        icone = img
        grupo = grupoAnimal
    }
    
    
}

println("A milhar \(milhar) pertence ao grupo \(grupo) do : \(bicho) \(icone) ")

