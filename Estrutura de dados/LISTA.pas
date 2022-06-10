Program Lista;

//Tamanho da Lista;
const iTamanhoLista = 4;

// Tipo Mesa;
type TIPO_MESA = record
    codigo : integer;
    nome   : string;
end;

// Tipo Lista;
type TIPO_LISTA = record
    iTamanhoAtual  : integer;
    iTamanhoMaximo : integer;
    aLista 	       : array [1..iTamanhoLista] of TIPO_MESA;
end;

//Vari�vel para usar no programa principal;
var Lista:TIPO_LISTA;
var Mesa:TIPO_MESA;
var iDefine:integer;
var iOpcao:integer;
var iCodigo:integer;

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
	          		writeln('Item n�o est� na lista.');
	          	end;
        end;
end;

//Procedimento para imprimir a Lista             
//@param Lista TIPO_LISTA - Lista que será imprimida.
procedure imprimeLista(var Lista:TIPO_LISTA);      
var iIndice:integer;
begin
    writeln('Mesas disponíveis:');
    writeln('Código | Nome');
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
		    writeln('Digite o nome da Mesa');
		    readln(Mesa.nome);
		    writeln(Mesa.nome,' Seu código é : ',Mesa.codigo,'.');
	    end;
end;

//Procedimento que realiza a leitura do nome e gera o código da Mesa a ser removida do sistema.
//@param Mesa TIPO_LISTA - Variável com a Lista a ser modificada.
//@param Mesa TIPO_MESA - Variável com a Mesa a ser removida.
procedure preparaMesaForRemocao(Lista:TIPO_LISTA; var Mesa:TIPO_MESA);
begin
    if not (verificaListaVazia(Lista)) then
	    begin
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

Begin
preparaLista(Lista);
while iDefine <> 1 do
    begin
        writeln('1. Inserir' );
        writeln('2. Remover' );
        writeln('3. Imprimir');
        writeln('4. Cheia'   );
        writeln('5. Vazia'   );
        writeln('6. Sair'    );
        readln(iOpcao);
        clrscr;
        if (iOpcao = 1) then
            begin
                preparaMesaForInclusao(Lista, Mesa, iCodigo);
                insereItemLista(Lista, Mesa);
            end
        else if (iOpcao = 2) then
            begin
            		preparaMesaForRemocao(Lista, Mesa);
                removeItemLista(Lista, Mesa);
            end
        else if (iOpcao = 3) then
            begin
                imprimeLista(Lista);
            end
        else if (iOpcao = 4) then
            begin
                writeln('Cheia : ',verificaListaCheia(Lista));
            end
        else if (iOpcao = 5) then
            begin
                writeln('Vazia : ',verificaListaVazia(Lista));
            end
        else if (iOpcao = 6) then
            begin
                iDefine:= 1;
            end
        else 
            writeln('DIGITE CERTO!');
    end;
        
End.