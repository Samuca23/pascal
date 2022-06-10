program Dicionario;

// @Todo Tipos

{
 * Tipo usado no dicionário para facilitar futuras modificações.
 }
type PALAVRA = string;

{
 * Tipo Dicionario esse tipo é que contém as palavras e suas traduções.
 }
type TIPO_DICIONARIO = record
    palavraPortugues : PALAVRA;
    palavraIngles : PALAVRA
end;

{
 * Tipo que contem as palavras em português e em inglês.
 }
type ITEM_INFO = TIPO_DICIONARIO;
     
{
 * ITEM_LISTA alocação de um elemento.
 * ELEMENTO tipo que contém os elementos da lista.
 }
type  ITEM_LISTA = ^ELEMENTO;
	ELEMENTO = record
    dado : ITEM_INFO;
    proximoLista : ITEM_LISTA
end;

// @Todo Procedimentos

{
 * Prepara a lista para começar com <nil> indicando que está vazia.
 }
procedure preparaLista(var Lista:ITEM_LISTA);
begin
    Lista:= nil;
end;

{
 * Insere um novo item na <Lista>.
 * Se a <Lista> for igual a <nil> então realiza a inclusão do primeiro elemento na lista.
 * Se a <Lista> for diferente de <nil> então realiza a inclusão do elemento em ordem alfabética.
 * @param Lista ITEM_LISTA - Lista a ser inserido um item.
 * @param Dado ITEM_INFO - Informações a serem inseridas no item da <Lista>.
 }
procedure insereItemLista(var Lista:ITEM_LISTA; Dado:ITEM_INFO);
var eAuxiliar1, eAuxiliar2,eAuxiliar3 : ITEM_LISTA;
var bMemCheia : boolean;
var bInseriu : boolean;
begin
    { Variável que indica se a memória está cheia. Inicia considerando que está cheia.}
    bMemCheia:= true;

    { Aloca espaço em memória.}
    new(eAuxiliar1);

    {
     * Verifica se é <nil>.
     * Se for <nil> considera-se então que a memória está cheia.
     * Se não for <nil> considera-se então que foi alocado espaço em memória.
     }
    if (eAuxiliar1 = nil) then
        begin
        		textcolor(red);
            writeln('Memória Cheia.');
        end
    else 
        begin
            bMemCheia:= false;
        end;
    
    {
     * Verifica se a memória não está cheia.
     * Se estiver cheia, não executa o processamento.
     * Se não estiver cheia, executa o processamento.
     }
    if not (bMemCheia) then
        begin
            {Se for igual a <nil> significa que é o primeiro item.}
            if (Lista = nil) then
                begin
                    eAuxiliar1^.dado:= Dado; 
                    eAuxiliar1^.proximoLista:= Lista; 
                    Lista:= eAuxiliar1;
                end
            {Se não for igual a <nil> entende-se que não é o primeiro item.}
            else  
                begin
                    eAuxiliar2:= Lista;
                    bInseriu:= false;
                    {Verifica se o item inicial da lista deve ser modificado.}
                    if (Dado.palavraPortugues < eAuxiliar2^.dado.palavraPortugues) then
                        begin
                            eAuxiliar1^.proximoLista:= eAuxiliar2;
                            eAuxiliar1^.dado:= Dado;
                            Lista:= eAuxiliar1;
                            bInseriu:= true;
                        end
                    else 
                        begin       
                            while (eAuxiliar2^.proximoLista <> nil) do
                                begin
                                	  if not (bInseriu) then
                                	  		begin
                                                {Se na ordem alfabética o dado for menor que dado do elemento atual faz o processamento necessário}
                                                if (Dado.palavraPortugues < eAuxiliar2^.proximoLista^.dado.palavraPortugues) then
                                                    begin
                                                    	{Pega o endereço de memória do elemento atual.}
                                                    	eAuxiliar3:= eAuxiliar2;
                                                        {Pega o endereço de memória do elemento posterior ao atual.}
                                                        eAuxiliar2:= eAuxiliar2^.proximoLista;
                                                        {Define que o elemento a ser inserido entre o atual e o proximo vai apontar para o proximo.}
                                                        eAuxiliar1^.proximoLista:= eAuxiliar2;
                                                        eAuxiliar1^.dado:= Dado;
                                                        {Define que o atual aponte para o novo elemento.}
                                                        eAuxiliar3^.proximoLista:= eAuxiliar1;
                                                        bInseriu:= true;
                                                    end
                                                else 
                                                    begin
                                                        eAuxiliar2:= eAuxiliar2^.proximoLista;
                                                    end;
                                            end;
                                end;                                                                					
                            {Verifica se já foi inserido}
                            if not (bInseriu) then
                                begin
                                    {Verificar se o proximo da lista aponta pra <nil>}
                                    if (eAuxiliar2^.proximoLista = nil) then 
                                        begin
                                            eAuxiliar1^.dado:= Dado;
                                            eAuxiliar1^.proximoLista:= nil;
                                            eAuxiliar2^.proximoLista:= eAuxiliar1;
                                        end;
                                end;
                        end;
                end;
        end;
end;

{
 * Imprime todos os elementos da <Lista>.
 * @param Lista ITEM_LISTA - Lista a ser inserido um item.
 }
procedure imprimeLista(Lista:ITEM_LISTA);
var ListaLocal:ITEM_LISTA;
begin
    ListaLocal:= Lista;
    if (ListaLocal <> nil) then
        begin            
            while (ListaLocal <> nil) do 
                begin
                    writeln(ListaLocal^.dado.palavraPortugues);
                    ListaLocal:= ListaLocal^.proximoLista;
                end;
        end
    else 
        begin
        		textcolor(red);
            writeln('Lista Vazia.');
        end;
end;

{
 * Imprime todos os elementos da <Lista>.
 * @param Dado ITEM_INFO - Realiza a leitura das informações da palavra desejada do usuário.
 }
procedure lePalavra(var Dado:ITEM_INFO);
begin
		textcolor(white);
    writeln('Digite a palavra em português.');
    readln(Dado.palavraPortugues);
    writeln('Digite a palavra em Inglês.');
    readln(Dado.palavraIngles);
end;
{
 * Le a palavra em português que o usuário deseja consultar na <Lista>.
 * @param ItemConsulta ITEM_INFO - Variável que contem o conteúdo desejado.
 }
procedure leItemConsulta(var ItemConsulta:ITEM_INFO);
begin
		textcolor(white);
    writeln('Digite a palavra que deseja consultar.');
    readln(ItemConsulta.palavraPortugues);
end;
{
 * Imprime a consulta da palavra para o usuário.
 * @param Lista ITEM_LISTA - Variável o item da lista desejado.
 }
procedure imprimeConsulta(var Lista:ITEM_LISTA);
begin
		textcolor(white);
		clrscr;
    writeln('============Consulta De Palavra============');
    writeln('Português: ', Lista^.dado.palavraPortugues);
    writeln('Inglês: ', Lista^.dado.palavraIngles);
    writeln('===========================================');
end;
{
 * Imprime todos os elementos da <Lista>.
 * @param Dado ITEM_INFO - Realiza a leitura das informações da palavra desejada do usuário.
 }
procedure consultaItem(Lista:ITEM_LISTA);
var ItemConsulta:ITEM_INFO;
var bAchou:boolean;
begin
    //Variável invertida.
    bAchou:= true;
    leItemConsulta(ItemConsulta);
    if (Lista <> nil) then  
        begin
            while (Lista <> nil) do 
                begin
                		if (bAchou) then
                			begin
		                    if (Lista^.dado.palavraPortugues = ItemConsulta.palavraPortugues) then
		                        begin
		                            imprimeConsulta(Lista);
		                            bAchou:= false; 
		                            Lista:= nil;		                            
		                        end;
                			end;
		                  Lista:= Lista^.proximoLista;
                end;
            if (bAchou) then 
                begin
                		textcolor(red);
                    writeln('A Palavra não foi encontrada.');
                end;
        end
    else 
        begin
        		textcolor(red);
            writeln('Não é possível consultar.');
        end;
end;

{
 * Le a palavra em português que o usuário deseja excluir na <Lista>.
 * @param ItemConsulta ITEM_INFO - Variável que contem o conteúdo desejado.
 }
procedure leItemExclusao(var ItemExclusao:ITEM_INFO);
begin
		textcolor(white);
    writeln('Digite a palavra que deseja EXCLUIR.');
    readln(ItemExclusao.palavraPortugues);
end;
{
 * Imprime a palavra que o usuario informou para excluir.
 * @param Lista ITEM_LISTA - Variável o item da lista desejado.
 }
procedure imprimeExclusao(var Lista:ITEM_LISTA);
begin
		textcolor(red);
    writeln('============Exclusao De Palavra============');
    writeln('A palavra ', Lista^.dado.palavraPortugues, ' foi excluida com sucesso!');
    writeln('===========================================');
    readkey;
    clrscr;
end;
{
 * Imprime todos os elementos da <Lista>.
 * @param Dado ITEM_INFO - Realiza a leitura das informações da palavra desejada do usuário.
 }
procedure ExcluiItem(Lista:ITEM_LISTA);
var ItemExclusao:ITEM_INFO;
var eAuxiliar1: ITEM_LISTA;
var bAchou:boolean;
begin
    //Variável invertida.
    bAchou:= true;
    leItemExclusao(ItemExclusao);
    if (Lista <> nil) then  
        begin
            while (Lista <> nil) do 
                begin
                		if (bAchou) then
                			begin
		                    if (Lista^.dado.palavraPortugues = ItemExclusao.palavraPortugues) then
		                        begin
		                        		eAuxiliar1:= Lista;
		                            imprimeExclusao(Lista);
		                            bAchou:= false; 
		                            Lista:= nil;		        
																dispose (eAuxiliar1);                    
		                        end;
                			end;
		                  Lista:= Lista^.proximoLista;
                end;
            if (bAchou) then 
                begin
                		textcolor(red);
                    writeln('A Palavra não foi encontrada.');
                end;
        end
    else 
        begin
        		textcolor(red);
            writeln('Não é possível consultar.');
        end;
end;


{
 * Insere um item na <Pilha>.
 * @param Pilha ITEM_LISTA - Pilha que será adicionada a informação.
 * @param Dado ITEM_INFO - Variável com as informações a serem inseridas.
 }
procedure inserePilha(var Pilha:ITEM_LISTA; Dado:ITEM_INFO);
var eAuxiliar1, eAuxiliar2,eAuxiliar3 : ITEM_LISTA;
var bMemCheia : boolean;
var bInseriu : boolean;
begin
    { Variável que indica se a memória está cheia. Inicia considerando que está cheia.}
    bMemCheia:= true;

    { Aloca espaço em memória.}
    new(eAuxiliar1);

    {
     * Verifica se é <nil>.
     * Se for <nil> considera-se então que a memória está cheia.
     * Se não for <nil> considera-se então que foi alocado espaço em memória.
     }
    if (eAuxiliar1 = nil) then
        begin
        		textcolor(red);
            writeln('Memória Cheia.');
        end
    else 
        begin
            bMemCheia:= false;
        end;
    
    {
     * Verifica se a memória não está cheia.
     * Se estiver cheia, não executa o processamento.
     * Se não estiver cheia, executa o processamento.
     }
    if not (bMemCheia) then
        begin
            {Primeiro elemento}
            if (Pilha = nil) then
                begin
                    eAuxiliar1^.dado:= Dado;
                    eAuxiliar1^.proximoLista:= nil;
                    Pilha:= eAuxiliar1;
                end
            else 
                begin
                		eAuxiliar2:= Pilha;
                    while (eAuxiliar2^.proximoLista <> nil) do
                        begin
                            eAuxiliar2:= eAuxiliar2^.proximoLista;
                        end;
                        eAuxiliar1^.dado:= Dado;
                        eAuxiliar1^.proximoLista:= nil;
                        eAuxiliar2^.proximoLista:= eAuxiliar1;
                end;
        end;
end;

{
 * Remove um item da <Pilha>.
 * @param PilhaOriginal ITEM_LISTA - Pilha original.
 * @param Item ITEM_LISTA - Item a ser removido.
 }
procedure removeItemPilha(var PilhaOriginal:ITEM_LISTA; Item:ITEM_LISTA);
var eAuxiliar1:ITEM_LISTA;
var Pilha:ITEM_LISTA;
begin
    Pilha:= PilhaOriginal;
    if (Pilha = nil) then
        begin
        		textcolor(red);
            writeln('Pilha Vazia');
        end
    else 
        begin
            if (Pilha^.proximoLista = nil) then
                begin
                    if (Pilha = Item) then
                        begin
                            PilhaOriginal:= nil; 
                        end;
                end
            else
                begin
                    while (Pilha^.proximoLista <> nil) do 
                        begin
                            if (Pilha^.proximoLista = Item) then
                                begin
                                    Pilha^.proximoLista:= nil; 
                                end;
                           	  	Pilha:=Pilha^.proximoLista;
                        end;
                end;
        end;
end;

{
 * Insere um item da <Lista Inversa>.
 * @param Lista ITEM_LISTA - Lista que será inserida a informação.
 * @param Dado ITEM_INFO - Informações a serem inseridas.
 }
procedure insereItemListaInversa(var Lista:ITEM_LISTA; Dado:ITEM_INFO);
var eAuxiliar1:ITEM_LISTA;
var eAuxiliar2:ITEM_LISTA;
var bMemCheia:boolean;
begin
    { Variável que indica se a memória está cheia. Inicia considerando que está cheia.}
    bMemCheia:= true;

    { Aloca espaço em memória.}
    new(eAuxiliar1);

    {
     * Verifica se é <nil>.
     * Se for <nil> considera-se então que a memória está cheia.
     * Se não for <nil> considera-se então que foi alocado espaço em memória.
     }
    if (eAuxiliar1 = nil) then
        begin
        		textcolor(red);
            writeln('Memória Cheia.');
        end
    else 
        begin
            bMemCheia:= false;
        end;
    
    {
     * Verifica se a memória não está cheia.
     * Se estiver cheia, não executa o processamento.
     * Se não estiver cheia, executa o processamento.
     }
    if not (bMemCheia) then
        begin
        		eAuxiliar2:= Lista;
            if (Lista = nil) then 
                begin
                    eAuxiliar1^.dado:= Dado;
                    eAuxiliar1^.proximoLista:= Lista;
                    Lista:= eAuxiliar1;
                end
            else 
                begin
                    while (eAuxiliar2^.proximoLista <> nil) do
                        eAuxiliar2:= eAuxiliar2^.proximoLista;

                    eAuxiliar1^.dado:= Dado;
                    eAuxiliar1^.proximoLista:= nil;
                    eAuxiliar2^.proximoLista:= eAuxiliar1;
                end;
        end;
end;

{
 * Realizar a inversão da <Lista Original>.
 * @param ListaOriginal ITEM_LISTA - Lista Original que será invertida.
 * @param Lista ITEM_LISTA - Lista que retornará a invertida.
 }
procedure inverteLista(ListaOriginal:ITEM_LISTA;var  Lista:ITEM_LISTA);
var Pilha:ITEM_LISTA;
var eAuxiliar1:ITEM_LISTA;
var ListaCopia:ITEM_LISTA;
begin
    ListaCopia:= ListaOriginal;

    {Adiciona todos os elementos da lista na Pilha.}
    while (ListaCopia <> nil) do
        begin
            inserePilha(Pilha, ListaCopia^.dado);
            ListaCopia:= ListaCopia^.proximoLista;
        end;

    {Recriar a pilha colocando sempre no final o item da pilha.}
    while (Pilha <> nil) do
        begin
		        eAuxiliar1:= Pilha;
	          {Pega sempre o último da pilha.}
	          while (eAuxiliar1^.proximoLista <> nil) do 
	              begin
	                  eAuxiliar1:= eAuxiliar1^.proximoLista;
	              end;
	                  removeItemPilha(Pilha, eAuxiliar1);
	                  
            insereItemListaInversa(Lista, eAuxiliar1^.dado);
            dispose(eAuxiliar1);
        end;

end;

// @Todo Variáveis Globais

var Lista:ITEM_LISTA;
var ListaInversa:ITEM_LISTA;
var Dado:ITEM_INFO;
var Operador:integer;

// @Todo Programa Principal

begin
		textcolor(white);
    preparaLista(Lista);
    Operador:= 1;
    while (Operador <> 0) do
        begin
            writeln('1. Insere');
            writeln('2. Imprime');
            writeln('3. Consulta');
            writeln('4. Cria Lista Invertida');
            writeln('5. Imprime Lista invertida');
            writeln('6- Excluir Item');
            textcolor(red);
            writeln('0. Sair');
            readln(Operador);
            clrscr;
            if (Operador = 1) then
                begin
                    lePalavra(Dado);
                    insereItemLista(Lista, Dado)
                end
            else if (Operador = 2) then
                begin
                    imprimeLista(Lista);
                end
            else if (Operador = 3) then
                begin
                    consultaItem(Lista);
                end
            else if (Operador = 4) then
                begin
                		ListaInversa:= nil;
                    inverteLista(Lista, ListaInversa);
                end
            else if (Operador = 5) then
                begin
                    imprimeLista(ListaInversa);
                end
            else if (Operador = 6) then
            		begin
            			 	ExcluiItem (Lista);
            		end;
        end;
end.
