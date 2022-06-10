Program FIFO ;

	const iMax = 10;
	
	type aVetor = array [1..iMax] of integer;
	
	var iQntGoblal, iRepete, iOpcao: integer;
			FilaGoblal: aVetor;
	
	//Funcao que retorna se a fila está vazia ou nao;
	function FilaVazia (iQnt:integer):boolean;
	begin
		if (iQnt = 0) then 
			FilaVazia:= true  							//true para vazia;
		else
			FilaVazia:= false; 							// false para nao vazia;
	end;
	
	//Funcao que retorna se a fila esta cheia ou nao;
	function FilaCheia (iQnt:integer):boolean;
	begin
		if (iQnt = iMax) then
			FilaCheia:= true   									// true para cheia;
		else
			FilaCheia:= false; 							//false quando não estiver cheia;
	end;
	
	//procedimento para inserir elementos na fila;
	procedure Inserir(var iQnt:integer; var Fila:aVetor);
	begin
		if not (FilaCheia(iQnt)) then 							
			begin
				iQnt:= iQnt + 1;
				writeln('Informe o elemento ', iQnt);
				readln(Fila[iQnt]);
			end
		else
			begin
				writeln;
				writeln('FILA CHEIA!'); 					//se estiver cheia, retorna a mensagem;
				writeln;
			end;
	end;
	
	// procedimento para remover o primeiro elemento da fila;
	procedure Remover (var iQnt: integer; var Fila:aVetor);
	var i:integer;
	begin
		if (FilaVazia(iQnt)) then  
			begin
				writeln;
				writeln('FILA VAZIA. IMPOSSIVEL REMOVER');
				writeln;
			end
		else
			begin
				Fila[1]:= 0;  								//primeiro elemento recebe 0;
				for i:= 1 to iQnt-1 do  
					begin
						Fila[i]:= Fila[i+1];
					end;		
					Fila[iQnt]:= 0;
					iQnt:= iQnt - 1;
				writeln('REMOVIDO COM SUCESSO');
			end;
	end;
	
	//procedimento para imprimir os elementos da fila;
	procedure Impressao (iQnt: integer;Fila:aVetor);
	var i:integer;
	begin
		if (FilaVazia(iQnt)) then 
			begin
				writeln;
				writeln('FILA VAZIA');
				writeln;
			end
		else
			begin
				writeln;
				writeln('FILA ATUAL:');
				for i:= 1 to iQnt do
					writeln(Fila[i]);
			end;
	end;

	//procedimento para saber se a fila esta cheia;
	procedure Fila_Cheia(var iQnt:integer);
	begin
		if (FilaCheia(iQnt)= true) then
			begin
				writeln;
				writeln('FILA CHEIA');
				writeln;
			end
		else if (FilaCheia(iQnt)= false) then
			begin
				writeln;
				writeln('A FILA NAO ESTA CHEIA');
				writeln;
			end;
	end;
	
	//procedimento para saber se a fila esta vazia;	
	procedure Fila_Vazia (var iQnt:integer);
	begin
		if (FilaVazia(iQnt)= true) then
			begin
				writeln;
				writeln('FILA VAZIA');
				writeln;
			end
		else if (FilaVazia(iQnt)= false) then
			begin
				writeln;
				writeln('A FILA NAO ESTA VAZIA');
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
		writeln('4- Fila cheia');
		writeln('5- Fila vazia');
		writeln('6- SAIR');
		writeln('=================');
		readln(iOpcao);
		clrscr;
		if (iOpcao = 1) then
			Inserir(iQntGoblal, FilaGoblal)	
		else if (iOpcao = 2) then
			Remover(iQntGoblal, FilaGoblal)	
		else if (iOpcao = 3) then
			Impressao(iQntGoblal, FilaGoblal)
		else if (iOpcao = 4) then
			Fila_Cheia(iQntGoblal)
		else if (iOpcao = 5) then
			Fila_Vazia(iQntGoblal)
		else if (iOpcao = 6) then  
			iRepete:= 6
		else 
			writeln('Nao existe essa opcao!');
	end;
End.