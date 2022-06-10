Program arvore;
type
    PtrNodoArvBin = ^NodoArvBin;
    NodoArvBin = Record
    Conteudo:Integer;
    ArvEsq,ArvDir,Pai:PtrNodoArvBin;
End;
const ESQUERDA = 1;
const DIREITA = 2;
var Raiz:PtrNodoArvBin;         

Procedure PreOrdem (Raiz: PtrNodoArvBin);
    begin
        if (Raiz <> nil) then
        begin
            write(Raiz^.conteudo, '-');
            PreOrdem(Raiz^.Arvesq);
            PreOrdem(Raiz^.Arvdir);
        end;
    end;

Procedure EmOrdem (Raiz: PtrNodoArvBin);
    begin
        if (raiz <> nil) then 
        begin
            EmOrdem(Raiz^.Arvesq);
            write(raiz^.conteudo, '-');
            EmOrdem(Raiz^.Arvdir);
        end;
    end;

Procedure PosOrdem (Raiz: PtrNodoArvBin);
    begin
        if (raiz <> nil) then 
        begin
            PosOrdem(Raiz^.Arvesq);
            PosOrdem(Raiz^.Arvdir);
            write(raiz^.conteudo, '-');
        end;
    end;

procedure InicializaArvBin (var Raiz:PtrNodoArvBin);
    begin
        Raiz:=Nil;
    end;

Procedure MostraNodosFolha (Raiz: PtrNodoArvBin);
    begin
        if (raiz <> nil) then 
	        begin
	            if (Raiz^.ArvEsq = NIL) and (Raiz^.ArvDir = NIL) then
	                write(raiz^.conteudo, '-');
	            MostraNodosFolha(Raiz^.Arvesq);
	            MostraNodosFolha(Raiz^.Arvdir);
	        end;
    end;

procedure ApagaArvBin (Raiz:PtrNodoArvBin);
    begin
        if (raiz <> nil) then
        begin
            ApagaArvBin(Raiz^.ArvEsq);
            ApagaArvBin(Raiz^.ArvDir);
            Dispose(Raiz);
        end;
    end;

procedure ContaNodos (Raiz:PtrNodoArvBin;var Cont:Integer);
    begin
        if (Raiz <> nil) then 
        begin
            inc(cont);
            ContaNodos(Raiz^.ArvEsq,Cont);
            ContaNodos(Raiz^.ArvDir,Cont);
        end;
    end;

procedure SomaNodos (Raiz:PtrNodoArvBin;var Soma:Integer);
    begin
        if (raiz <> nil) then 
        begin
            soma:= soma + Raiz^.Conteudo;
            SomaNodos(Raiz^.ArvEsq,Soma);
            SomaNodos(Raiz^.ArvDir,Soma);
        end;
    end;

function PesquisaArvBinPesq (Raiz:PtrNodoArvBin; x:Integer):PtrNodoArvBin;
var ptr:PtrNodoArvBin;
    begin
        ptr:=Raiz;
        while (ptr <> nil) and (ptr^.conteudo <> x) do
            if (x > ptr^.conteudo) then 
                ptr:=ptr^.ArvDir
            else 
                ptr:=ptr^.ArvEsq;
        PesquisaArvBinPesq:=ptr;
    end;

function MenorValor (Raiz:PtrNodoArvBin):PtrNodoArvBin;
    begin
        if (Raiz^.ArvEsq <> nil) then 
            MenorValor:=MenorValor(Raiz^.ArvEsq)
        else
            MenorValor:=Raiz;
    end;

function MaiorValor (Raiz:PtrNodoArvBin):PtrNodoArvBin;
    begin
        if (Raiz^.ArvDir <> nil) then 
            MaiorValor:=MaiorValor(Raiz^.ArvDir)
        else
            MaiorValor:=Raiz;
    end;

function Nivel (arv: PtrNodoArvBin; valor,n: Integer; var achou: boolean): integer;
    begin
        if not (achou) then 
            if (arv <> nil) then 
                if (arv^.conteudo = valor) then 
                    begin
                        achou := true;
                        Nivel := n;
                    end
                else 
                    begin
                        Nivel := Nivel(arv^.Arvesq, valor, n + 1, achou);
                        if not (achou) then 
                            Nivel := Nivel(arv^.Arvdir, valor, n + 1, achou);
                    end
            else nivel := -1;
    end;


function Maior(a,b:integer):integer;
    begin
        if (a > b) then
            Maior := a
        else
            Maior := b;
    end;

function Altura (raiz:PtrNodoArvBin):integer;
    begin
        if (raiz = NIL) then    
            Altura := -1
        else 
            Altura := 1 + Maior(altura(raiz^.ArvEsq), altura(raiz^.ArvDir));
    end;

Procedure MostraArvore (Raiz:PtrNodoArvBin; lin, col, colanterior:integer);
    begin
        if (Raiz <> nil) then 
        begin
            MostraArvore(Raiz^.ArvEsq, lin+1, col - abs(colanterior-col) div 2, col);
            gotoxy(col,lin);
            write(Raiz^.Conteudo);
            MostraArvore(Raiz^.ArvDir, lin+1, col + abs(colanterior-col) div 2, col);
        end;
    end;

function MaiorCaminho (Raiz:PtrNodoArvBin):String;
    begin
        if (raiz = Nil) then 
            MaiorCaminho:=''
        else 
            if (altura(raiz) = 0) then 
                MaiorCaminho:=''
            else 
                if (altura(raiz^.ArvEsq) > altura(raiz^.ArvDir)) then 
                    MaiorCaminho:='E' + MaiorCaminho(raiz^.ArvEsq)
                else 
                    MaiorCaminho:='D' + MaiorCaminho(raiz^.ArvDir);
    end;

procedure processaInclusao(var Node:PtrNodoArvBin; newContent:integer; iLado:integer);
var newNode:PtrNodoArvBin;
begin
 	new(newNode);
 	newNode^.conteudo:= newContent;
 	newNode^.ArvEsq:= nil;
    newNode^.ArvDir:= nil;
   	newNode^.Pai:= Node;
	if (iLado = ESQUERDA) then
     Node^.ArvEsq:= newNode
	else 
		 Node^.ArvDir:= newNode;
end;

procedure processaInclusaoFirst(var Node:PtrNodoArvBin; newContent:integer);
var newNode:PtrNodoArvBin;
begin
   new(newNode);
 	 newNode^.conteudo:= newContent;
 	 newNode^.ArvEsq:= nil;
 	 newNode^.ArvDir:= nil;
 	 newNode^.Pai:= nil;
 	 Node:= newNode;
end;

procedure insere(var Node:PtrNodoArvBin; newContent:integer);
begin
	if (Node = nil) then
		processaInclusaoFirst(Node, newContent)
	else
		begin
            if (Node^.conteudo > newContent) then
                        if (Node^.ArvEsq = nil) then 
                            processaInclusao(Node, newContent, ESQUERDA)
                        else 
                            insere(Node^.ArvEsq, newContent)
                else 
                    if (Node^.ArvDir = nil) then 
                            processaInclusao(Node, newContent, DIREITA)
                        else 
                            insere(Node^.ArvDir, newContent);
	    end;
end;

function getNewContent():integer;
var iNumero:integer;
begin
	writeln('Digite um número.');
	readln(iNumero);
	getNewContent:=iNumero;
end;

function isFull(Raiz:PtrNodoArvBin):boolean;
var retorno,bentrou:boolean;
begin
	if (Raiz = nil) then
		isFull:= true
	else 
		begin
            bentrou:=false;
            retorno:= false;
			if ((Raiz^.ArvEsq = nil) and (Raiz^.ArvDir = nil)) then
				begin
					retorno:=true
				end
			else if ((Raiz^.ArvEsq <> nil) and (Raiz^.ArvDir <> nil)) then
                begin
                    if (isFull(Raiz^.ArvEsq) = false) then
                        bentrou:= true;
                    if (isFull(Raiz^.ArvDir) = false) then
                        bentrou:= true;
                    if not (bentrou) then
                       retorno:= true; 
                end;
            isFull:= retorno;
		end;			
end;

function getMenorSubArv(var Node:PtrNodoArvBin):integer;
var iMenor,iRetorno:integer;
begin
    iRetorno:= Node^.conteudo;
    iMenor:= Node^.conteudo;

    if (Node^.ArvDir <> nil) then
        iRetorno := getMenorSubArv(Node^.ArvDir);

    if (iMenor > iRetorno) then
        iMenor:= iRetorno;    
    
    if (Node^.ArvEsq <> nil) then
        iRetorno := getMenorSubArv(Node^.ArvEsq);

    if (iMenor > iRetorno) then
        iMenor:= iRetorno;  

    getMenorSubArv:= iMenor;
end;

procedure delete(var Node:PtrNodoArvBin; iNumero:integer);
var auxiliar:PtrNodoArvBin;
var iMenor:integer;
begin
    
    if (iNumero > Node^.conteudo) then
        begin
            delete(Node^.ArvDir, iNumero);
        end
    else if (iNumero < Node^.conteudo) then 
        begin
            delete(Node^.ArvEsq, iNumero);
        end
    else if (iNumero = Node^.conteudo) then
        begin
            if (Node^.ArvDir <> nil) and (Node^.ArvEsq <> nil) then
                begin
                    iMenor := getMenorSubArv(Node^.ArvDir);
                    Node^.conteudo := iMenor;
                    delete(Node^.ArvDir, iMenor);
                end
            else if (Node^.ArvDir <> nil) then
                begin
                    Node^.ArvDir^.Pai:= Node^.Pai;
                    if (Node^.Pai^.conteudo > Node^.conteudo) then
                        Node^.Pai^.ArvEsq:= Node^.ArvDir
                    else
                        Node^.Pai^.ArvDir:= Node^.ArvDir;
                    Dispose(Node^.ArvDir);
                end
            else if (Node^.ArvEsq <> nil) then
                begin
                    Node^.ArvEsq^.Pai:= Node^.Pai;
                    if (Node^.Pai^.conteudo > Node^.conteudo) then
                        Node^.Pai^.ArvEsq:= Node^.ArvEsq
                    else
                        Node^.Pai^.ArvDir:= Node^.ArvEsq;
                    Dispose(Node^.ArvEsq);
                end
            else 
                begin
                    if (Node^.Pai^.conteudo > Node^.conteudo) then
                        Node^.Pai^.ArvEsq:= nil
                    else
                        Node^.Pai^.ArvDir:= nil;
                    Dispose(Node);
                end;
        end;


end;

{Faz o menu da tela.}
procedure menu();
var i:integer;
var Node:PtrNodoArvBin;
var iQuantidade:integer;
begin
	InicializaArvBin(Raiz);
	i:= 1;
	while (i <> 0) do
		begin
			clrscr;
			writeln('1. Inserir');
			writeln('2. Escrever Folhas');
			writeln('3. Conta Nós');
			writeln('4. In Order');
			writeln('5. Pre Order');
			writeln('6. Pós Order');
			writeln('7. Altura');
			writeln('8. Completa');
			writeln('9. Mostra Arvore');
			writeln('10. Deletar');
			writeln('0. Sair');
			readln(i);
			if (i = 1) then 
				insere(Raiz, getNewContent()) 
			else if (i = 2) then
				MostraNodosFolha(Raiz)
			else if (i = 3) then
				begin
					iQuantidade:= 0;
					ContaNodos(Raiz, iQuantidade);
					writeln(iQuantidade,' números');
				end
			else if (i = 4) then
				EmOrdem(Raiz)
			else if (i = 5) then
				PreOrdem(Raiz)
			else if (i = 6) then
				PosOrdem(Raiz)
			else if (i = 7) then
				writeln(Altura(Raiz))
			else if (i = 8) then
				writeln(isFull(Raiz))
			else if (i = 9) then
				MostraArvore(Raiz, 0, 0, 0)
			else if (i = 10) then
				delete(Raiz, getNewContent());
			readkey;
		end;
end;


Begin
  menu();   	
End.