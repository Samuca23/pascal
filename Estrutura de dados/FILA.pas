Program FILA;

//Tamanho da Fila;
const iTamanhoFila = 4;

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

//Vari�vel para usar no programa principal;
var Fila:TIPO_FILA;
var Pessoa:TIPO_PESSOA;
var iDefine:integer;
var iOpcao:integer;
var iCodigo:integer;

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
    for iIndice:=1 to Fila.iTamanhoAtual do
        begin
            writeln(Fila.aFila[iIndice].codigo,' . ',Fila.aFila[iIndice].nome);
        end;
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
		    writeln('Digite o nome da pessoa');
		    readln(Pessoa.nome);
		    writeln(Pessoa.nome,' Seu código é : ',Pessoa.codigo,'.');
	    end;
end;

//Procedimento que prepara a fila com os seus atributos padr�es
//@param Fila TIPO_FILA - Variável que cont�m a fila a ser preparada.
procedure preparaFila(var Fila:TIPO_FILA);
begin
	  Fila.iTamanhoMaximo:= iTamanhoFila;
	  Fila.iTamanhoAtual:= 0;
end;


Begin
preparaFila(Fila);
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
                preparaPessoaForInclusao(Fila, Pessoa, iCodigo);
                insereItemFila(Fila, Pessoa);
            end
        else if (iOpcao = 2) then
            begin
                removeItemFila(Fila);
            end
        else if (iOpcao = 3) then
            begin
                imprimeFila(Fila);
            end
        else if (iOpcao = 4) then
            begin
                writeln('Cheia : ',verificaFilaCheia(Fila));
            end
        else if (iOpcao = 5) then
            begin
                writeln('Vazia : ',verificaFilaVazia(Fila));
            end
        else if (iOpcao = 6) then
            begin
                iDefine:= 1;
            end
        else 
            writeln('DIGITE CERTO!');
    end;
        
End.