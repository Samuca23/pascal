Program Pzim ;

const iTamMaxPilha = 6;
type TIPO_PILHA = array [1..iTamMaxPilha] of integer;

var iQntPrato:integer;
		iPilhaPrato: TIPO_PILHA;
		
function iSituacaoPratoVazia (iQntPrato: integer):boolean;
	begin
		if (iQntPrato = 0) then 
			iSituacaoPratoVazia:= true  							
		else
			iSituacaoPratoVazia:= false; 							
	end;
	
function iSituacaoPratoCheia (iQntPrato:integer):boolean;
	begin
		if (iQntPrato = iTamMaxPilha) then
			iSituacaoPratoCheia:= true   									
		else
			iSituacaoPratoCheia:= false; 							
	end;

procedure Pratos (var iQntPrato: integer; var iPilhaPrato: TIPO_PILHA);
var iIndice:integer;
begin
	for iIndice:= 1 to iTamMaxPilha do
		iPilhaPrato[iIndice]:= iIndice;
	if not (iSituacaoPratoCheia(iQntPrato)) then
		begin
			for iIndice:= 1 to iTamMaxPilha do
				iPilhaPrato[iIndice]:=iIndice-iIndice;	
		end
	else 
		writeln ('Sem pratos!');

end;

Begin
Pratos(iQntPrato, iPilhaPrato);  
End.