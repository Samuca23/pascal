Program Pzim ;

type tipoValor = integer;

type ItemPilha = ^elemento;
		 elemento = record
		 		dado: tipoValor;
				Proximo: ItemPilha;
		 end;

var   Pilha_numero:ItemPilha;
    num:tipoValor;
    Opcao:byte; 


procedure LeituraPilha (var valor:tipoValor);
	begin
		write('Informe o valor: ');
		readln(Valor);
	end; 

procedure CriaPilha (var Pilha: ItemPilha);
	begin
		Pilha:= nil;
	end;

procedure IncluiPilha (var Pilha:ItemPilha; Valor:tipoValor);
var Auxiliar, Auxiliar2: ItemPilha;
	begin
		new(Auxiliar);
		if (Auxiliar = nil) then
			begin
				writeln('Memoria cheia');
			end
		else
			begin
				if (Pilha = nil) then
					begin
						Auxiliar^.dado:= Valor;
						Auxiliar^.Proximo:= nil;
						Pilha:= Auxiliar; 	
					end
				else
					begin
						Auxiliar2:= Pilha;
						while (Auxiliar2^.Proximo <> nil) do
							begin
								Auxiliar2:= Auxiliar2^.Proximo;
							end;
					  Auxiliar^.dado:= Valor;
					  Auxiliar^.Proximo:=nil;
					  Auxiliar2^.Proximo:= Auxiliar;
					end;
			end;
	end;

procedure ExcluiPilha (var Pilha:ItemPilha);
var Auxiliar: ItemPilha; 
var Auxiliar2: ItemPilha;
	begin
		if (Pilha = nil) then
			begin
				writeln('Pilha vazia');
				readkey;
			end
		else
			begin
				Auxiliar:= Pilha;
				Auxiliar2:= Pilha;
				if (Pilha^.Proximo = nil) then
					begin
						Pilha:= nil;
						//dispose(Pilha); 	
					end
				else
					begin
						while (Auxiliar^.Proximo <> nil) do
							begin
								Auxiliar:= Auxiliar^.Proximo;
							end;
						while (Auxiliar2^.Proximo <> nil) do 
							begin
								if (Auxiliar2^.Proximo = Auxiliar) then
									begin
										Auxiliar2^.Proximo:= nil;
									end;
								Auxiliar2:= Auxiliar2^.Proximo;
							end;
							writeln('Elemento excluido ', Auxiliar^.dado);
							dispose(Auxiliar);
							readkey;
						end;				
			end;
	end;
	
Function Conta_Elementos (Pilha:ItemPilha):byte;
var Auxiliar:ItemPilha;
    i:byte;

Begin
   if Pilha=nil then
      i:=0
   else
      Begin
         i:=0;
         Auxiliar:=Pilha;
         while Auxiliar <> nil do
         begin
            i:=i+1;
            writeln(i,' - ',Auxiliar^.dado);
            Auxiliar:=Auxiliar^.proximo;
         end;
      End;
   Conta_Elementos:=i
End;


Begin
Opcao:=1;
    CriaPilha(Pilha_numero);
    while Opcao<>0 do
    begin
       clrscr;
       writeln ('0-Sair');
       writeln ('1-Incluir');
       writeln ('2-Remover');
       writeln ('3-Contar Elementos');
       readln (Opcao);
       writeln;
       case Opcao of
          1: begin
               LeituraPilha(num);
               IncluiPilha(Pilha_numero,num)
             end;
          2: begin
              ExcluiPilha(Pilha_numero);
             end;
          3: begin
               writeln (conta_elementos(Pilha_numero),' elementos');
               readkey;
             end;
       end;
    end;  
End.