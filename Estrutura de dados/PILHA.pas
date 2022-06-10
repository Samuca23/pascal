Program Pilha ;

	const iMax = 10;
	
	type aVetor = array [0..iMax] of integer;
	
	var iQntGoblal, iRepete, iOpcao: integer;
			PilhaGoblal: aVetor;
	
	//Funcao que retorna se a pilha está vazia ou nao;
	function PilhaVazia (iQnt:integer):boolean;
	begin
		if (iQnt = 0) then 
			PilhaVazia:= true  							
		else
			PilhaVazia:= false; 							
	end;
	
	//Funcao que retorna se a pilha esta cheia ou nao;
	function PilhaCheia (iQnt:integer):boolean;
	begin
		if (iQnt = iMax) then
			PilhaCheia:= true   									
		else
			PilhaCheia:= false; 							
	end;
	
	//procedimento para inserir elementos na pilha;
	procedure Inserir(var iQnt:integer; var Pilha:aVetor);
	begin
		if not (PilhaCheia(iQnt)) then 							
			begin
				iQnt:= iQnt + 1;
				writeln('Informe o elemento ', iQnt);
				readln(Pilha[iQnt]);
			end
		else
			begin
				writeln;
				writeln('PILHA CHEIA!'); 					
				writeln;
			end;
	end;
	
	// procedimento para remover o primeiro elemento da pilha;
	procedure Remover (var iQnt: integer; var Pilha:aVetor);
	var i:integer;
	begin
		if (PilhaVazia(iQnt)) then  
			begin
				writeln;
				writeln('PILHA VAZIA. IMPOSSIVEL REMOVER');
				writeln;
			end
		else
			begin  								
				for i:= 1 to iQnt do  
					begin
						Pilha[iQnt]:= Pilha[iQnt - 1] 
					end;		
					Pilha[iQnt]:= 0;
					iQnt:= iQnt - 1;
				writeln('REMOVIDO COM SUCESSO');
			end;
	end;
	
	//procedimento para imprimir os elementos da pilha;
	procedure Impressao (iQnt: integer;Pilha:aVetor);
	var i:integer;
	begin
		if (PilhaVazia(iQnt)) then 
			begin
				writeln;
				writeln('PILHA VAZIA');
				writeln;
			end
		else
			begin
				writeln;
				writeln('PILHA ATUAL:');
				for i:= iQnt downto 1 do
					writeln(Pilha[i]);
			end;
	end;

	//procedimento para saber se a pilha esta cheia;
	procedure Pilha_Cheia(var iQnt:integer);
	begin
		if (PilhaCheia(iQnt)= true) then
			begin
				writeln;
				writeln('PILHA CHEIA');
				writeln;
			end
		else if (PilhaCheia(iQnt)= false) then
			begin
				writeln;
				writeln('A PILHA NAO ESTA CHEIA');
				writeln;
			end;
	end;
	
	//procedimento para saber se a pilha esta vazia;	
	procedure Pilha_Vazia (var iQnt:integer);
	begin
		if (PilhaVazia(iQnt)= true) then
			begin
				writeln;
				writeln('PILHA VAZIA');
				writeln;
			end
		else if (PilhaVazia(iQnt)= false) then
			begin
				writeln;
				writeln('A PILHA NAO ESTA VAZIA');
				writeln;
			end;
	end;
			
Begin
// Menu de opcoes
while iRepete <> 6 do
	begin
		writeln;
		writeln('MENU DE OPCOES');
		writeln('=================');
		writeln('1- Inserir');
		writeln('2- Remocao');
		writeln('3- Impressao');
		writeln('4- Pilha cheia');
		writeln('5- Pilha vazia');
		writeln('6- SAIR');
		writeln('=================');
		readln(iOpcao);
		clrscr;
		if (iOpcao = 1) then
			Inserir(iQntGoblal, PilhaGoblal)	
		else if (iOpcao = 2) then
			Remover(iQntGoblal, PilhaGoblal)	
		else if (iOpcao = 3) then
			Impressao(iQntGoblal, PilhaGoblal)
		else if (iOpcao = 4) then
			Pilha_Cheia(iQntGoblal)
		else if (iOpcao = 5) then
			Pilha_Vazia(iQntGoblal)
		else if (iOpcao = 6) then  
			iRepete:= 6
		else 
			writeln('Nao existe essa opcao!');
	end;
End.