[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4nHL7_6-)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18897689&assignment_repo_type=AssignmentRepo)
# CS 164: Programming Assignment 1

[PA1 Specification]: https://drive.google.com/open?id=1oYcJ5iv7Wt8oZNS1bEfswAklbMxDtwqB
[ChocoPy Specification]: https://drive.google.com/file/d/1mrgrUFHMdcqhBYzXHG24VcIiSrymR6wt

Note: Users running Windows should replace the colon (`:`) with a semicolon (`;`) in the classpath argument for all command listed below.

## Getting started

Run the following command to generate and compile your parser, and then run all the provided tests:

    mvn clean package

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s --test --dir src/test/data/pa1/sample/

In the starter code, only one test should pass. Your objective is to build a parser that passes all the provided tests and meets the assignment specifications.

To manually observe the output of your parser when run on a given input ChocoPy program, run the following command (replace the last argument to change the input file):

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s src/test/data/pa1/sample/expr_plus.py

You can check the output produced by the staff-provided reference implementation on the same input file, as follows:

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=r src/test/data/pa1/sample/expr_plus.py

Try this with another input file as well, such as `src/test/data/pa1/sample/coverage.py`, to see what happens when the results disagree.

## Assignment specifications

See the [PA1 specification][] on the course
website for a detailed specification of the assignment.

Refer to the [ChocoPy Specification][] on the CS164 web site
for the specification of the ChocoPy language. 

## Receiving updates to this repository

Add the `upstream` repository remotes (you only need to do this once in your local clone):

    git remote add upstream https://github.com/cs164berkeley/pa1-chocopy-parser.git

To sync with updates upstream:

    git pull upstream master


## Submission writeup

Team member 1: Dário Chen Chen Ye

Team member 2: Fellipe Carvalho Pombo Lima

Team member 3: Leonardo Meato Fernandes

(Students should edit this section with their write-up)

Projeto desenvolvido em X horas.

Respostas às perguntas:

1) 	O controle de identação do lexer foi feito no estado INDENT_CTRL, que vai da linha 172 à 235, sendo que o acesso a esse estado é feito na linha 94. Também há uma parte dos tokens que é emitida no EOF, da linha 238 à 242.

	A estratégia foi a seguinte: toda vez que uma linha é quebrada (enquanto no estado principal do lexer), o analisador vai para o estado INDENT_CTRL, no qual os espaços em branco são contados. Na seção de declarações do jflex, há algumas variáveis declaradas, sendo a principal delas a pilha de identação, que começa com um 0. Após a contagem dos espaços em branco, compara-se o topo da pilha de identação com a quantidade contada: caso a quantidade seja maior que a do topo da pilha, essa quantidade é adicionada ao topo da pilha e é emitido um token INDENT;caso a quantidade seja igual, nada acontece; caso a quantidade seja menor, o topo da pilha é descartado e é emitido um token DEDENT. Em todos esses casos, logo após a operação descrita volta-se para o estado principal, a não ser que, após a emissão do DEDENT, a quantidade de espaços em branco ainda seja menor que o topo da pilha. Nesse caso, utiliza-se a função yypushback() para voltar ao começo do espaço em branco e não é feita mudança de estado, forçando o algoritmo descrito a ser executado novamente, até que a identação esteja correta.

	No entanto, a contagem de espaços em branco só será feita caso haja espaços em branco e a regra {WhiteSpace} seja requisitada. Se esse não for o caso, é porque a identação é 0, então são emitidos quantos DEDENTs forem necessários, seguindo uma lógica parecida com a descrita acima, porém dando sempre um pushback(1) para não contar o caracter que não é um espaço em branco como consumido.

	Além disso, é possível que o programa acabe com DEDENTs ainda para serem emitidos, porém sem uma quebra de linha no fim do programa. Nesse caso, o estado INDENT_CTRL não será acionado. Para isso, há um pequeno trecho no EOF para emitir os tokens restantes.

	Há também mecanismos para eliminar NEWLINEs redundantes, para que não seja emitido DEDENT INDENT dentro de um mesmo bloco por conta de uma quebra de linha desnecessária, por exemplo.

2) 	A relação é muito grande. O algoritmo descrito pelo manual do ChocoPy foi seguido praticamente à risca.