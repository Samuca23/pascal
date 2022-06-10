Program Restaurante;

//Tamanho da Fila;
const iTamanhoFila = 8;
//Tamanho da Pilha;
const iTamanhoPilha = 6;

// Tipo Pessoa;
type TIPO_PESSOA = record
    codigo : integer;
    nome   : string;
end;

// Tipo Fila;
type TIPO_FILA = record
    iTamanhoAtual  : integer;
    iTamanhoMaximo : integer;
    aFila 	       : array [1..iTamanhoFila] of TIPO_PESSOA;
end;
// Tipo Pilha;
type TIPO_PILHA = record
    iTamanhoAtual  : integer;
    iTamanhoMaximo : integer;
    aPilha 	       : array [1..iTamanhoPilha] of integer;
end;

//Tamanho da Lista;
const iTamanhoLista = 4;

// Tipo Mesa;
type TIPO_MESA = record
    codigo : integer;
    nome   : string;
    Pessoa : TIPO_PESSOA;
end;

// Tipo Lista;
type TIPO_LISTA = record
    iTamanhoAtual  : integer;
    iTamanhoMaximo : integer;
    aLista 	       : array [1..iTamanhoLista] of TIPO_MESA;
end;


//Vari�vel para usar no programa principal;
var FilaChegada:TIPO_FILA;
var FilaPesagem:TIPO_FILA;
var FilaPagamento:TIPO_FILA;
var PilhaPratos:TIPO_PILHA;
var Pessoa:TIPO_PESSOA;
var Lista:TIPO_LISTA;
var Mesa:TIPO_MESA;
var iDefine:integer;
var iOpcao:integer;
var iCodigoMesa:integer;
var iCodigoPessoa:integer;

//Função para verificar se a Lista recebida como parametro está cheia.
//@param Lista TIPO_LISTA - Lista que será verificada.
function verificaListaCheia(Lista:TIPO_LISTA):boolean;
begin
    verificaListaCheia:= false;
    if (Lista.iTamanhoAtual = Lista.iTamanhoMaximo) then
        verificaListaCheia:= true;
end;

//Função para verificar se a Lista recebida como parametro está vazia.
//@param Lista TIPO_LISTA - Lista que será verificada.
function verificaListaVazia(Lista:TIPO_LISTA):boolean;
begin
    verificaListaVazia:= false;
    if (Lista.iTamanhoAtual = 0) then
        verificaListaVazia:= true;
end;

//Procedimento para adicionar um item na Lista.
//@param Lista TIPO_LISTA - Lista que recebera uma item.
//@param Mesa TIPO_MESA - Mesa que será inserida na fila.
procedure insereItemLista(var Lista:TIPO_LISTA; Mesa:TIPO_MESA);
var iIndice:integer;
var xSaveFor:TIPO_MESA;
var xSave:TIPO_MESA;
var bInserido:boolean;
begin
	bInserido:= false;
	if (verificaListaCheia(Lista)) then
		begin
        writeln('Lista cheia.');
		end
    else
        if (verificaListaVazia(Lista)) then
            begin
                Lista.iTamanhoAtual:= Lista.iTamanhoAtual + 1;
                Lista.aLista[Lista.iTamanhoAtual]:= Mesa;
            end
        else 
            begin
                //Percorrer toda a lista verificando onde a mesa deve ser inserida para manter a lista ordenada
                Lista.iTamanhoAtual:= Lista.iTamanhoAtual + 1;
                for iIndice:= 1 to Lista.iTamanhoAtual do
                    begin
                        if (Mesa.codigo < Lista.aLista[iIndice].codigo) then 
                            begin
                                // Salvar o indíce atual.
                                xSave:= Lista.aLista[iIndice];
                                // Colocar a mesa na posição que ela deve.
                                Lista.aLista[iIndice]:= Mesa;
                                //Incrementar para a posição após a inserida.
                                iIndice:=iIndice + 1;
                                for iIndice:=iIndice to Lista.iTamanhoAtual do
                                    begin
                                        // Salvar novamente o próximo indice.
                                        xSaveFor:= Lista.aLista[iIndice];
                                        //Colocar na posição a frente o que estava no indice anterior.
                                        Lista.aLista[iIndice]:= xSave;
                                        // Salvando o proximo antes de inserir.
                                        xSave:= xSaveFor;
                                    end;
                                bInserido:= true;
                            end;
                       	//Se for a ultima posição então a próxima recebe o do anterior.
                       	if (iIndice = Lista.iTamanhoAtual) then
                       		if (bInserido = false)  then
                        		 Lista.aLista[iIndice]:= Mesa;
                    end;
            end;
end;

//Procedimento para remover um item na Lista.
//@param Lista TIPO_LISTA - Lista que será removido um item.
//@param Mesa TIPO_MESA - Mesa que será removida.
procedure removeItemLista(var Lista:TIPO_LISTA; Mesa:TIPO_MESA);
var iIndice:integer;
var bRemovido:boolean;
var MesaVazia:TIPO_MESA;
begin
		bRemovido:= false;
    if (verificaListaVazia(Lista)) then
        begin
            writeln('Lista vazia.');
        end
    else 
        begin
            for iIndice:=1 to Lista.iTamanhoAtual do
                begin
                    if (Lista.aLista[iIndice].codigo = Mesa.codigo) then
                        begin
                        		bRemovido:= true;
                            for iIndice:=iIndice to Lista.iTamanhoAtual do
                                begin
                                    if (iIndice = Lista.iTamanhoAtual) then
                                        begin
                                            Lista.aLista[iIndice] := MesaVazia;
                                        end
                                    else 
                                        Lista.aLista[iIndice] := Lista.aLista[iIndice+1]
                                end;
                        end;
                end;
            if (bRemovido) then
	            Lista.iTamanhoAtual:= Lista.iTamanhoAtual - 1
	          else 
	          	begin
	          		writeln('Item nao esta na lista.');
	          	end;
        end;
end;

//Procedimento para imprimir a Lista             
//@param Lista TIPO_LISTA - Lista que será imprimida.
procedure imprimeLista(var Lista:TIPO_LISTA);      
var iIndice:integer;
begin
		textColor(White);
    writeln('Mesas disponiveis:');
    writeln('Codigo | Nome');
    for iIndice:=1 to Lista.iTamanhoAtual do
        begin
            writeln(Lista.aLista[iIndice].codigo,'. ',Lista.aLista[iIndice].nome);
        end;
end;

//Procedimento que realiza a leitura do nome e gera o código da Mesa a ser inserida no sistema.
//@param Mesa TIPO_MESA - Variável com a Mesa a ser inserida.
//@param iCodigo Integer - Variável usada para fazer a geração do código da Mesa.
procedure preparaMesaForInclusao(Lista:TIPO_LISTA; var Mesa:TIPO_MESA; var iCodigo:integer);
begin
    if not (verificaListaCheia(Lista)) then
	    begin
			  iCodigo:= iCodigo + 1;
		    Mesa.codigo:= iCodigo;
		    textColor(White);
		    writeln('Digite o nome da Mesa');
		    readln(Mesa.nome);
		    writeln(Mesa.nome,' Seu odigo e : ',Mesa.codigo,'.');
	    end;
end;

//Procedimento que realiza a leitura do nome e gera o código da Mesa a ser removida do sistema.
//@param Mesa TIPO_LISTA - Variável com a Lista a ser modificada.
//@param Mesa TIPO_MESA - Variável com a Mesa a ser removida.
procedure preparaMesaForRemocao(Lista:TIPO_LISTA; var Mesa:TIPO_MESA);
begin
    if not (verificaListaVazia(Lista)) then
	    begin
	    	textColor(White);
		    writeln('Digite o codigo da Mesa');
		    readln(Mesa.codigo);
	    end;
end;

//Procedimento que prepara a Lista com os seus atributos padr�es
//@param Lista TIPO_LISTA - Variável que cont�m a Lista a ser preparada.
procedure preparaLista(var Lista:TIPO_LISTA);
begin
	Lista.iTamanhoMaximo:= iTamanhoLista;
	Lista.iTamanhoAtual:= 0;
end;

//Função para verificar se a Fila recebida como parametro está cheia.
//@param Fila TIPO_FILA - Fila que será verificada.
function verificaFilaCheia(Fila:TIPO_FILA):boolean;
begin
    verificaFilaCheia:= false;
    if (Fila.iTamanhoAtual = Fila.iTamanhoMaximo) then
        verificaFilaCheia:= true;
end;

//Função para verificar se a Fila recebida como parametro está vazia.
//@param Fila TIPO_FILA - Fila que será verificada.
function verificaFilaVazia(Fila:TIPO_FILA):boolean;
begin
    verificaFilaVazia:= false;
    if (Fila.iTamanhoAtual = 0) then
        verificaFilaVazia:= true;
end;

//Procedimento para adicionar um item na Fila.
//@param Fila TIPO_FILA - Fila que recebera uma item.
procedure insereItemFila(var Fila:TIPO_FILA; Pessoa:TIPO_PESSOA);
begin
	if (verificaFilaCheia(Fila)) then
		begin
        writeln('Fila cheia.');
		end
    else
        begin
            Fila.iTamanhoAtual:= Fila.iTamanhoAtual + 1;
            Fila.aFila[Fila.iTamanhoAtual]:= Pessoa;
        end;
end;

//Procedimento para organizar a Fila depois de uma remoção
//@param Fila TIPO_FILA - Fila que será organizada.
procedure organizaRemocao(var Fila:TIPO_FILA);
var iIndice:integer;
var Pessoa:TIPO_PESSOA;
begin
    for iIndice:=1 to Fila.iTamanhoAtual do
        begin
        		if (iIndice = Fila.iTamanhoAtual) then
	        		begin
	        			 Fila.aFila[iIndice]:= Pessoa;
	        		end;
            Fila.aFila[iIndice]:= Fila.aFila[iIndice+1];
        end;
end;

//Procedimento para remover um item na Fila.
//@param Fila TIPO_FILA - Fila que será removido um item.
procedure removeItemFila(var Fila:TIPO_FILA);
var Pessoa:TIPO_PESSOA;
begin
    if (verificaFilaVazia(Fila)) then
        begin
            writeln('Fila vazia.');
        end
    else 
        begin
            Fila.aFila[1]:= Pessoa;
            Fila.iTamanhoAtual:= Fila.iTamanhoAtual - 1;
            organizaRemocao(Fila);
        end;
end;

//Procedimento para imprimir a Fila             
//@param Fila TIPO_FILA - Fila que será imprimida.
procedure imprimeFila(var Fila:TIPO_FILA);      
var iIndice:integer;
begin
		if not (verificaFilaVazia(Fila)) then
    for iIndice:=1 to Fila.iTamanhoAtual do
        begin
            writeln(Fila.aFila[iIndice].codigo,' . ',Fila.aFila[iIndice].nome);
        end
    else
    	writeln('Fila vazia.')
end;

//Procedimento que realiza a leitura do nome e gera o código da pessoa a ser inserida no sistema.
//@param Pessoa TIPO_PESSOA - Variável com a pessoa a ser inserida.
//@param iCodigo Integer - Variável usada para fazer a geração do código da pessoa.
procedure preparaPessoaForInclusao(Fila:TIPO_FILA; var Pessoa:TIPO_PESSOA; var iCodigo:integer);
begin
    if not (verificaFilaCheia(Fila)) then
	    begin
				iCodigo:= iCodigo + 1;
		    Pessoa.codigo:= iCodigo;
		    textColor(White);
		    writeln('Digite o nome da pessoa');
		    readln(Pessoa.nome);
		    writeln(Pessoa.nome,' Seu codigo e : ',Pessoa.codigo,'.');
	    end;
end;

//Procedimento que prepara a fila com os seus atributos padr�es
//@param Fila TIPO_FILA - Variável que cont�m a fila a ser preparada.
procedure preparaFila(var Fila:TIPO_FILA; iTamanho:integer);
begin
	  Fila.iTamanhoMaximo:= iTamanho;
	  Fila.iTamanhoAtual:= 0;
end;

//Função para verificar se existe uma mesa disponível
//@param Lista TIPO_LISTA - Lista de mesas.
function verificaMesaDisponivel(Lista:TIPO_LISTA):integer;
var iIndice:integer;
begin
    verificaMesaDisponivel:= 0;
    for iIndice:=1 to Lista.iTamanhoAtual do
        begin
            if (Lista.aLista[iIndice].pessoa.codigo = 0) then
                begin
                    verificaMesaDisponivel:= iIndice;
                    iIndice:= Lista.iTamanhoAtual;
                end;
        end;
end;

//Procedimento para imprimir na tela as mesas disponíveis.
//@param Lista TIPO_LISTA - Lista de mesas.
procedure imprimeMesasDisponiveis(Lista:TIPO_LISTA);
var iIndice:integer;
var aArrayMesas: array [1..iTamanhoLista] of TIPO_MESA;
var iQuantidadeMesas: integer;
begin
    iQuantidadeMesas:= 0;
    if not (verificaListaVazia(Lista)) then
        begin
            for iIndice:= 1 to Lista.iTamanhoAtual do
                begin
                    if (Lista.aLista[iIndice].Pessoa.codigo = 0) then
                        begin
                            iQuantidadeMesas:= iQuantidadeMesas+1;
                            aArrayMesas[iQuantidadeMesas]:= Lista.aLista[iIndice];
                        end;
                end;
            if (iQuantidadeMesas = 0) then
                begin
                    writeln('Nao ha mesas disponiveis.')
                end
            else 
                begin
                		textColor(White);
                    writeln('Mesas disponiveis : ',iQuantidadeMesas,'.');
                    writeln('Codigo | Nome Mesa');
                    for iIndice:=1 to iQuantidadeMesas do
                        begin
                            writeln(aArrayMesas[iIndice].codigo,'. ',aArrayMesas[iIndice].nome,'.')
                        end;
                end;
        end
    else 
        writeln('Nao existem mesas na lista de mesas.')
end;

//Procedimento para pegar o indice de uma mesa disponível.
//@param Lista TIPO_LISTA - Lista de mesas.
//@param iCodigoMesa Integer - Código da mesa de deseja-se saber o índice.
function getIndiceMesaDisponivel(Lista:TIPO_LISTA; iCodigoMesa:integer):integer;
var iIndice:integer;
var bAchou:boolean;
begin
    bAchou:= false;
    if (verificaListaVazia(Lista)) then
        begin
            writeln('A lista de mesas esta vazia.');
        end
    else 
        begin
            for iIndice:=1 to Lista.iTamanhoAtual do
                begin
                    if (Lista.aLista[iIndice].codigo = iCodigoMesa) then
                        begin
                            if (Lista.aLista[iIndice].pessoa.codigo = 0) then
                                begin
                                    getIndiceMesaDisponivel:= iIndice;
                                    bAchou:= true;
                                end;
                        end;
                end;
            if (iIndice = Lista.iTamanhoAtual) then
                begin
                    if not (bAchou) then
                        begin
                            writeln('Nao existe uma mesa disponivel com esse codigo.');
                            getIndiceMesaDisponivel:= 0;
                        end;
                end;
        end;                  
end;


//Procedimento para realizar a escolha de uma mesa, baseada na pessoa que está na vez da fila.
//@param Lista TIPO_LISTA - Lista de mesas que podem ser escolhidas.
//@param FilaPesagem TIPO_FILA - Fila de pesagem dos pratos.
procedure escolheMesa(var Lista:TIPO_LISTA; var FilaPesagem:TIPO_FILA);
var Pessoa:TIPO_PESSOA;
var iCodigoMesaDisponivel:integer;
var iCodigoMesaDesejada:integer;
begin
    if not (verificaFilaVazia(FilaPesagem)) then
        begin
            if not (verificaListaVazia(Lista)) then
                begin
                    iCodigoMesaDisponivel:= verificaMesaDisponivel(Lista);
                    if (iCodigoMesaDisponivel > 0) then
                        begin
                        		textColor(White);
                            Pessoa:= FilaPesagem.aFila[1];
                            imprimeMesasDisponiveis(Lista);
                            writeln('Cliente: ',Pessoa.nome);
                            writeln('Digite o codigo da mesa desejada.');
                            readln(iCodigoMesaDesejada);
                            //getIndiceMesa para pegar o indice da mesa no array de mesas do sistema.
                            Lista.aLista[getIndiceMesaDisponivel(Lista, iCodigoMesaDesejada)].pessoa:= Pessoa;
                            removeItemFila(FilaPesagem);
                            writeln('Pesagem realizada. ',pessoa.nome, ' O valor do seu prato e: R$',random(51),'.00');
                        end
                    else 
                        writeln('Nao existem mesas disponiveis');
                end
            else 
                writeln('Nao existem mesas disponiveis');
        end
    else 
        writeln('Nao existe ninguim na fila de pesagem.');
end;

//Função que retorna se a lista está valida para receber algum tipo de tratamento.
//@param Lista TIPO_LISTA - Lista a ser validada.
function validaLista(Lista:TIPO_LISTA):boolean;
begin
    validaLista:= true;
    if (verificaListaVazia(Lista)) then
        begin
            writeln('A lista esta� vazia.');
            validaLista:= false;
        end;
end;

//Função para retornar o indice de uma mesa a partir do código desta mesa.
//@param Lista TIPO_LISTA - Lista de mesas na qual quer se descobrir o índice da mesa.
//@param iCodigoMesa Integer - Código da mesa que deseja-se descobrir o índice.
function getIndiceMesaFromCodigo(Lista:TIPO_LISTA; iCodigoMesa:integer):integer;
var iIndice:integer;
var bAchou:boolean;
begin
    bAchou:= false;
    if (validaLista(Lista)) then
        begin
            for iIndice:= 1 to Lista.iTamanhoAtual do
                begin
                    if (Lista.aLista[iIndice].codigo = iCodigoMesa) then
                        begin
                            getIndiceMesaFromCodigo:= iIndice;
                            bAchou:= true;
                        end;
                end;

            if (iIndice = Lista.iTamanhoAtual) then
                if not (bAchou) then
                	begin
                    writeln('Esta mesa nao esta na lista.');
                    getIndiceMesaFromCodigo:= 0;
                	end;
        end;
end;

//Procedimento para realizar a entrada na fila de pagamento.
//@param FilaPagamento TIPO_FILA - Fila na qual deseja-se entrar.
procedure entrarFilaPagamento(var FilaPagamento:TIPO_FILA; var Lista:TIPO_LISTA);
var iIndice:integer;
var iCodigoMesaPagamento:integer;
var iIndiceMesa:integer;
var Pessoa:TIPO_PESSOA;
var newPessoa:TIPO_PESSOA;
begin
    textColor(White);
    writeln('Digite o codigo da mesa');
    readln(iCodigoMesaPagamento);
    if (getIndiceMesaFromCodigo(Lista, iCodigoMesaPagamento) = 0) then
        writeln('Verifique se as informacoes estao corretas. Processamento foi cancelado.') 
    else
        begin        
            Pessoa:= Lista.aLista[getIndiceMesaFromCodigo(Lista, iCodigoMesaPagamento)].pessoa;
            if (Pessoa.codigo = 0) then
                begin
                    writeln('Nao existe pessoa para a mesa informada. Verifique as informacoes e tente novamente.');
                end
            else 
                begin
                    Lista.aLista[getIndiceMesaFromCodigo(Lista, iCodigoMesaPagamento)].pessoa:= newPessoa;
                    insereItemFila(FilaPagamento, Pessoa);
                    writeln('Cliente na vez: ', pessoa.nome);
                end;
        end;
end;

//Procedimento para realizar a inser��o de mesas na Lista do restaurante.
//@param Lista TIPO_LISTA - Lista de mesas dispon�veis no restaurante.
procedure preparaRestaurante(var Lista:TIPO_LISTA);
begin
	Lista.aLista[1].codigo:= 1;
	Lista.aLista[1].nome:= 'Mesa da esquerda';
	
	Lista.aLista[2].codigo:= 2;
	Lista.aLista[2].nome:= 'Mesa da direita';
	
	Lista.aLista[3].codigo:= 3;
	Lista.aLista[3].nome:= 'Mesa da centro';
	
	Lista.aLista[4].codigo:= 4;
	Lista.aLista[4].nome:= 'Mesa da fundo';
	
	Lista.iTamanhoAtual:= iTamanhoLista;
end;

//Pilha de pratos 

//Função para verificar se a Pilha recebida como parametro está cheia.
//@param Pilha TIPO_PILHA - Pilha que será verificada.
function verificaPilhaCheia(Pilha:TIPO_PILHA):boolean;
begin
    verificaPilhaCheia:= false;
    if (Pilha.iTamanhoAtual = Pilha.iTamanhoMaximo) then
        verificaPilhaCheia:= true;
end;

//Função para verificar se a Pilha recebida como parametro está vazia.
//@param Pilha TIPO_PILHA - Pilha que será verificada.
function verificaPilhaVazia(Pilha:TIPO_PILHA):boolean;
begin
    verificaPilhaVazia:= false;
    if (Pilha.iTamanhoAtual = 0) then
        verificaPilhaVazia:= true;
end;

//Procedimento para adicionar um item na Pilha.
//@param Pilha TIPO_PILHA - Pilha que recebera uma item.
procedure insereItemPilha(var Pilha:TIPO_PILHA; sNome:integer);
begin
	if (verificaPilhaCheia(Pilha)) then
		begin
            writeln('Pilha cheia.');
		end
    else
        begin
            Pilha.iTamanhoAtual:= Pilha.iTamanhoAtual + 1;
            Pilha.aPilha[Pilha.iTamanhoAtual]:= random(51);
        end;
end;

//Procedimento para remover um item na Pilha.
//@param Pilha TIPO_PILHA - Pilha que será removido um item.
procedure removeItemPilha(var Pilha:TIPO_PILHA);
var Vazio:integer;
begin
    if (verificaPilhaVazia(Pilha)) then
        begin
            writeln('Pilha vazia.');
        end
    else 
        begin
            Pilha.aPilha[Pilha.iTamanhoAtual]:= Vazio;
            Pilha.iTamanhoAtual:= Pilha.iTamanhoAtual - 1;
        end;
end;

//Procedimento para imprimir a Pilha             
//@param Pilha TIPO_PILHA - Pilha que será imprimida.
procedure imprimePilha(var Pilha:TIPO_PILHA);      
var iIndice:integer;
begin
		if not (verificaPilhaVazia(Pilha)) then
    for iIndice:=1 to Pilha.iTamanhoAtual do
        begin
            writeln(Pilha.aPilha[iIndice],' . ',Pilha.aPilha[iIndice]);
        end
    else
    	writeln('Pilha vazia.')
end;

//Procedimento que prepara a Pilha com os seus atributos padr�es
//@param Pilha TIPO_PILHA - Variável que cont�m a Pilha a ser preparada.
procedure preparaPilha(var Pilha:TIPO_PILHA; iTamanho:integer);
begin
	Pilha.iTamanhoMaximo:= iTamanho;
	Pilha.iTamanhoAtual:= 6;

    Pilha.aPilha[1]:= 1;
    Pilha.aPilha[2]:= 2;
    Pilha.aPilha[3]:= 3;
    Pilha.aPilha[4]:= 4;
    Pilha.aPilha[5]:= 5;
    Pilha.aPilha[6]:= 6;
end;

{
* Procedimento para pegar um prato caso tenha algum prato disponível
* @param FilaChegada TIPO_FILA - Fila de chegada do restaurante.
* @param Pilha TIPO_PILHA - Pilha de pratos do restaurante.
* @param FilaPesagem TIPO_FILA - Fila de pesagem dos pratos do restaurante.
}
procedure pegarPrato(var FilaChegada:TIPO_FILA; var Pilha:TIPO_PILHA; var FilaPesagem:TIPO_FILA);
begin
    // Verificar se a fila de pesagem está cheia se estiver não pode pegar um prato
    if (verificaFilaCheia(FilaPesagem)) then
        begin 
            writeln('A fila de pesagem esta cheia aguarde.')
        end
    else 
        begin
            // Verificar se existe na pilha um prato para poder ser pegado
            if (verificaPilhaVazia(Pilha)) then
                begin
                    writeln('Pilha vazia nao ha pratos, aguarde...');
                end
            else 
                begin
                    // Verificar se tem alguém na fila de chegada para poder pegar um prato
                    if (verificaFilaVazia(FilaChegada)) then
                        begin
                            writeln('A fila de chegada esta vazia nao ha pessoas para pegar pratos.');            
                        end
                    else 
                        begin
                            removeItemPilha(Pilha); 
                            // "Pega" o prato e vai para a fila de pesagem 
                            insereItemFila(FilaPesagem, FilaChegada.aFila[1]);
                            removeItemFila(FilaChegada);
                        end;
                end;
        end;
end;

{
 * Procedimento para realizar o pagamento, basicamente remove o primeiro da fila de pagamento e disponibiliza um prato na pilha
 * @param FilaPagamento TIPO_FILA - Fila de pagamento.
 * @param PilhaPratos TIPO_PILHA - Pilha de pratos.
}
procedure realizaPagamento(var FilaPagamento:TIPO_FILA; var PilhaPratos:TIPO_PILHA);
begin
    // A fila de pagamento está vazia?
    if (verificaFilaVazia(FilaPagamento)) then
        begin
            writeln('A fila de pagamento esta vazia.');
        end
    else 
        begin
            removeItemFila(FilaPagamento);
            insereItemPilha(PilhaPratos, random(51));
            textColor(White);
            writeln(pessoa.nome,' seu pagamento efetuado com sucesso!');
        end;
end;

Begin
//Esse cara vai receber a lista de mesa e a pilha de prato.
preparaRestaurante(Lista);
preparaFila(FilaChegada, iTamanhoFila);
preparaFila(FilaPagamento, iTamanhoFila);
preparaFila(FilaPesagem, 6);
preparaPilha(PilhaPratos, iTamanhoPilha);
//preparaLista(Lista);
textColor(White);
writeln('Pressione ENTER para come�ar');
readkey;
while iDefine <> 1 do
    begin
    		textColor(White);
        writeln('1. Entrar na Fila de chegada' );
        writeln('2. Pegar prato');
        writeln('3. Realizar pesagem');
        writeln('4. Entrar na Fila de pagamento');
        writeln('5. Realizar pagamento');
        writeln('6. Imprimir Fila chegada');
        writeln('7. Imprimir Fila pesagem');
        writeln('8. Imprimir Fila pagamento');
        writeln('9. Imprimir Lista Mesa');
        writeln('10. Imprimir Pilha de Pratos');
        textcolor(red);
        writeln('11. Sair');
        readln(iOpcao);
        clrscr;
        if (iOpcao = 1) then
            begin
                preparaPessoaForInclusao(FilaChegada, Pessoa, iCodigoPessoa);
                insereItemFila(FilaChegada, Pessoa);
            end
        else if (iOpcao = 2) then
            begin
                pegarPrato(FilaChegada, PilhaPratos, FilaPesagem);
            end
        else if (iOpcao = 3) then
            begin
                escolheMesa(Lista, FilaPesagem);
            end
        else if (iOpcao = 4) then
            begin
                entrarFilaPagamento(FilaPagamento, Lista);
            end
        else if (iOpcao = 5) then
            begin
                realizaPagamento(FilaPagamento, PilhaPratos);
            end
        else if (iOpcao = 6) then
            begin
                imprimeFila(FilaChegada);
            end
        else if (iOpcao = 7) then
            begin
                imprimeFila(FilaPesagem);
            end
        else if (iOpcao = 8) then
            begin
                imprimeFila(FilaPagamento);
            end
        else if (iOpcao = 9) then
            begin
                imprimeLista(Lista);
            end
        else if (iOpcao = 10) then
            begin
                imprimePilha(PilhaPratos);
            end
        else if (iOpcao = 11) then
            begin
                iDefine:= 1;
            end
        else 
            writeln('DIGITE CERTO!');
    end;
        
End.