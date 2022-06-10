Program DicionarioDinamico ;

 {
  Tipo para especificar string;
 }
type TipoPalavra = string;
{
 Tipo para especificar as palavra em Portgues e Ingles;
}
type ItemDicionario = record
			PalavraPortugues: TipoPalavra;
			PalavraIngles: TipoPalavra;
		 end;

type PortIngles = ItemDicionario;
{
 ItemLista que tem elementos para a lista;
}
type ItemLista = ^elemento;
		 elemento = record 
		 		dado: PortIngles;
		 		Ponteiro: ItemLista;
		 end;

var ListaDicionario: ItemLista;
var PalavraGlobal: PortIngles;
var Opcao: byte;
	
{A lista e criada;
}
procedure CriaLista (var Lista: ItemLista);
begin
	Lista:= nil;
end;

{!!PROCEDIMENTO COM ERRO, SO SALVA  O PRIMEIRO ENDERECO DE MEMORIA!!
A primeira palavra e inclusa e em seguida com mais palavras vao se ordenando;
}
//procedure IncluiPalavraLista (var Lista: ItemLista; Palavra: PortIngles);
//var Auxiliar, Auxiliar2, Auxiliar3: ItemLista;
//var MemoriaCheia, bInseriu: boolean;
//begin
//	MemoriaCheia:= true;
//	new(Auxiliar);
//	if (Auxiliar = nil) then
//		begin
//			writeln('A memoria esta cheia');
//		end
//	else
//		begin
//			MemoriaCheia:= false;
//		end;
//	if not (MemoriaCheia) then{Caso seja o primeiro elemento da Lista;}
//		begin
//			if (Lista=nil) then
//				begin
//					Auxiliar^.dado:=Palavra;
//					Auxiliar^.Ponteiro:=Lista;
//					Lista:= Auxiliar; 
//				end;
//		end
//	else
//		begin
//			Auxiliar2:= Lista;
//			bInseriu:= false;
//			if (Palavra.PalavraPortugues < Auxiliar2^.dado.PalavraPortugues) then
//				begin
//					Auxiliar^.Ponteiro:= Auxiliar2;
//					Auxiliar^.dado:= Palavra;
//					Lista:= Auxiliar;	
//					bInseriu:= true;
//				end
//			else
//				begin
//					while (Auxiliar2^.Ponteiro <> nil) do
//							begin
//								if not (bInseriu) then
//										begin
//											if (Palavra.PalavraPortugues < Auxiliar2^.Ponteiro^.dado.PalavraPortugues) then
//												begin
//													Auxiliar3:= Auxiliar2;
//													Auxiliar2:= Auxiliar2^.Ponteiro;
//													Auxiliar^.Ponteiro:= Auxiliar2;
//													Auxiliar^.dado:= Palavra;
//													Auxiliar3^.Ponteiro:= Auxiliar;
//													bInseriu:= true;
//												end
//										else
//												begin
//													Auxiliar2:= Auxiliar2^.Ponteiro;
//												end;
//									end;			
//						end;
//					if not (bInseriu) then
//						begin
//							if (Auxiliar2^.Ponteiro = nil) then
//								begin
//									Auxiliar^.dado:= Palavra;
//									Auxiliar^.Ponteiro:= nil;
//									Auxiliar2^.Ponteiro:= Auxiliar;
//								end;
//						end;
//				end;
//		end;
//end;

{!!Procedimento retirado do codigo do David!!
	Modificando os atributos;
}
procedure insereItemLista(var Lista:ItemLista; Palavra:PortIngles);
var eAuxiliar1, eAuxiliar2,eAuxiliar3 : ItemLista;
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
                    eAuxiliar1^.dado:= Palavra;
                    eAuxiliar1^.Ponteiro:= Lista; 
                    Lista:= eAuxiliar1;
                end
            {Se não for igual a <nil> entende-se que não é o primeiro item.}
            else  
                begin
                    eAuxiliar2:= Lista;
                    bInseriu:= false;
                    {Verifica se o item inicial da lista deve ser modificado.}
                    if (Palavra.PalavraPortugues < eAuxiliar2^.dado.PalavraPortugues) then
                        begin
                            eAuxiliar1^.Ponteiro:= eAuxiliar2;
                            eAuxiliar1^.dado:= Palavra;
                            Lista:= eAuxiliar1;
                            bInseriu:= true;
                        end
                    else 
                        begin       
                           while (eAuxiliar2^.Ponteiro <> nil) do
                                begin
                                	  if not (bInseriu) then
                                	  		begin
                                                {Se na ordem alfabética o dado for menor que dado do elemento atual faz o processamento necessário}
                                                if (Palavra.PalavraPortugues < eAuxiliar2^.Ponteiro^.dado.PalavraPortugues) then
                                                    begin
                                                    	{Pega o endereço de memória do elemento atual.}
                                                    	eAuxiliar3:= eAuxiliar2;
                                                        {Pega o endereço de memória do elemento posterior ao atual.}
                                                        eAuxiliar2:= eAuxiliar2^.Ponteiro;
                                                        {Define que o elemento a ser inserido entre o atual e o proximo vai apontar para o proximo.}
                                                        eAuxiliar1^.Ponteiro:= eAuxiliar2;
                                                        eAuxiliar1^.dado:= Palavra;
                                                        {Define que o atual aponte para o novo elemento.}
                                                        eAuxiliar3^.Ponteiro:= eAuxiliar1;
                                                        bInseriu:= true;
                                                    end
                                                else 
                                                    begin
                                                        eAuxiliar2:= eAuxiliar2^.Ponteiro;
                                                    end;
                                            end;
                                end;                                                                					
                            {Verifica se já foi inserido}
                            if not (bInseriu) then
                                begin
                                    {Verificar se o proximo da lista aponta pra <nil>}
                                    if (eAuxiliar2^.Ponteiro = nil) then 
                                        begin
                                            eAuxiliar1^.dado:= Palavra;
                                            eAuxiliar1^.Ponteiro:= nil;
                                            eAuxiliar2^.Ponteiro:= eAuxiliar1;
                                        end;
                                end;
                        end;
                end;
        end;
end;

{Listar as Palavras em Portugues.
}
procedure ListaPalavras (Lista:ItemLista);
var RecebeLista: ItemLista;
begin
	RecebeLista:= Lista;
	if (RecebeLista <> nil) then
		begin
			writeln('Portugues - Ingles');
			while (RecebeLista <> nil) do
				begin
					writeln(RecebeLista^.dado.PalavraPortugues,' - ', RecebeLista^.dado.PalavraIngles);
					RecebeLista:= RecebeLista^.Ponteiro;
				end;
		end
	else
		begin
			writeln ('A lista está vazia');
		end;
end;

{Le as palavras em Portugues e ingles;
}
procedure LeituraLista (var Palavra:PortIngles);
	begin
		write('Informe a palavra em POR: ');
		readln(Palavra.PalavraPortugues);
		write('Informe a palavra em ING: ');
		readln(Palavra.PalavraIngles);
	end;

{Procedimento separado para ler a palavra da consulta;
}	
procedure LePalavraConsulta (var PalavraDaConsulta: PortIngles);
begin
	writeln('Informe a palavra para consulta');
	readln(PalavraDaConsulta.PalavraPortugues);
end; 
{Procedimento para imprimir a palavra consultada;
}
procedure ImprimeConsultaFinal (var Lista: ItemLista);
begin
	writeln('Consulta das palavras');	
	writeln('Portugues: ', Lista^.dado.PalavraPortugues);	                           	
	writeln('Ingles: ', Lista^.dado.PalavraIngles);
end;
{Procedimento que faz toda a consulta e chama os outros procedimentos;
}
procedure ConsultaPalavraFinal (Lista: ItemLista);
var PalavraDaConsulta: PortIngles;
var EncontraPalavra: boolean;
begin
	EncontraPalavra:= true;
	LePalavraConsulta(PalavraDaConsulta);
	if (Lista <> nil) then
		begin
			while (Lista <> nil) do
				begin
					if (EncontraPalavra) then
						begin
							if (Lista^.dado.PalavraPortugues = PalavraDaConsulta.PalavraPortugues) then
								begin
									ImprimeConsultaFinal (Lista);
									EncontraPalavra:= false;
									Lista:= nil;
								end;
						end;
						Lista:= Lista^.Ponteiro;
				end;
			if (EncontraPalavra) then
				begin
					writeln('Palavra nao encontrada');
				end;
		end
	else
		begin
			writeln('Nao e possivel consultar');
		end;		
end;



{!!PROCEDIMENTO COM ERRO PARA EXCLUSAO!! - Nao informa que "Nao é possivel excluir" quando a lista esta vazia
}
procedure LePalavraExclusao (var PalavraDaConsulta: PortIngles);
begin
	writeln('Informe a palavra para EXCLUSAO');
	readln(PalavraDaConsulta.PalavraPortugues);
end;
 
{Procedimento para imprimir a palavra consultada;
}
procedure ImprimeExclusaoFinal (var Lista: ItemLista);
begin
	writeln('PALAVRA EXCLUIDA');	
end;
////
{Procedimento que faz toda a consulta e chama os outros procedimentos;
}
procedure ExclusaoPalavraFinal (Lista: ItemLista);
var PalavraDaExclusao: PortIngles;
var Auxiliar1: ItemLista;
var EncontraPalavra: boolean;
begin
	EncontraPalavra:= true;
	LePalavraExclusao(PalavraDaExclusao);
	if (Lista <> nil) then
		begin
			while (Lista <> nil) do
				begin
					if (EncontraPalavra) then
						begin
							if (Lista^.dado.PalavraPortugues = PalavraDaExclusao.PalavraPortugues) then
								begin
									Auxiliar1:= Lista;
									dispose(Auxiliar1);
									ImprimeExclusaoFinal (Lista);
									EncontraPalavra:= false;
									Lista:= nil;
								end;
						end;
						Lista:= Lista^.Ponteiro;
				end;
			if (EncontraPalavra) then
				begin
					writeln('Palavra nao encontrada');
				end;
		end
	else
		begin
			writeln('Nao e possivel Excluir');
		end;		
end;

Begin
		textcolor (white);
    CriaLista(ListaDicionario);
    Opcao:= 1;
    while (Opcao <> 0) do
    begin
       clrscr;
       writeln ('0-Sair');
       writeln ('1-Incluir');
       writeln ('2-Remover');
       writeln ('3-Listar elementos');
       writeln ('4-Consultar elemento');
       writeln ('5-Inverte Lista');
       readln (Opcao);
       writeln;
       if (Opcao = 1) then
       	begin
        	LeituraLista(PalavraGlobal);
          insereItemLista (ListaDicionario, PalavraGlobal);
        end
      else if (Opcao = 2) then
      	begin
          ExclusaoPalavraFinal(ListaDicionario);
        end
      else if (Opcao = 3) then
        begin
         	ListaPalavras(ListaDicionario);
        	readkey;
        end
      else if (Opcao = 4) then
      	begin
      		ConsultaPalavraFinal (ListaDicionario); 
      		readkey;
      	end
      else if (Opcao = 5) then
      	begin     		
      	end;
    end;   
End.