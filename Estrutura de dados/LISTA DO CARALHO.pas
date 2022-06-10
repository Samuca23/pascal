Program Lista ;

const iConstTamMax = 10;
Type 
			Registro_Lista = record
				iQnt: integer;
				aVetor: array [0..iConstTamMax] of integer;
				iTamMax: integer;
			end;
			
var iRepete, iOpcao: integer;
		iLista: Registro_Lista;


function iListaVazia (iLista: Registro_Lista):boolean;
	begin
		if (iLista.iQnt = 0) then 
			iListaVazia:=true  							
		else
			iListaVazia:=false; 							
	end;

 
function iListaCheia (iLista: Registro_Lista):boolean;
	begin
		if (iLista.iQnt=iLista.iTamMax) then
			iListaCheia:=true   									
		else
			iListaCheia:=false; 						
				
	end;

procedure iInsereLista(var iLista: Registro_Lista);
var iIndice: integer;
	begin
		if not (iListaCheia(iLista)) then 							
			begin
				writeln('Informe o elemento ', iLista.iQnt);
				readln(iLista.aVetor[iLista.iQnt]);
				iLista.iQnt:= iLista.iQnt+1;
				for iIndice:= 1 to iLista.iTamMax do
					begin
						if iLista.iQnt > iLista.aVetor[iIndice] then
							iLista.aVetor[iLista.iQnt]:= iLista.aVetor[iLista.iQnt+1];
					end;
			end
		else
			begin
				writeln;
				writeln('Lista cheia!'); 					
				writeln;
			end;
	end;
	
	


procedure iImprimeLista (var iLista: Registro_Lista);
	var i:integer;
	begin
		if (iListaVazia(iLista)) then 
			begin
				writeln;
				writeln('Lista Vazia');
				writeln;
			end
		else
			begin
				writeln;
				writeln('Lista atual:');
				for i:= 1 to iLista.iQnt do
					writeln(iLista.aVetor[i]);
			end;
	end;
					
Begin
iLista.iTamMax:= iConstTamMax;
while iRepete <> 6 do
	begin
		writeln;
		writeln('1- Inserir');
		writeln('2- Remocao');
		writeln('3- Impressao');
		writeln('4- Pilha cheia');
		writeln('5- Pilha vazia');
		writeln('6- SAIR');
		readln(iOpcao);
		clrscr;
		if (iOpcao = 1) then
			iInsereLista(iLista)
//		else if (iOpcao = 2) then
//			Remover(iQntGoblal, PilhaGoblal)	
		else if (iOpcao = 3) then
			iImprimeLista(iLista)
//		else if (iOpcao = 4) then
//			Pilha_Cheia(iQntGoblal)
//		else if (iOpcao = 5) then
//			Pilha_Vazia(iQntGoblal)
		else if (iOpcao = 6) then  
			iRepete:= 6
		else 
			writeln('Nao existe essa opcao!');
	end;
End.