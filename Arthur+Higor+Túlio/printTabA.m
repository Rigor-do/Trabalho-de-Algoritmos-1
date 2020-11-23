% Imprimir tabela, sendo,
% -  a matriz A composta pelos dados de cada célula da tabela. 
% - Leg é os títulos das colunas, a primeira linha da tabela, no formato array de cell.
% - n é o número de casas decimais no número, observe que o tamanho da coluna n aumenta mais do que o tamanho max do título
%   Exemplo printTabX(A, leg, 5, 'Tabela Leg - A' )

function printTabA( A, leg, n, titulo)
	fprintf('%s\n', titulo );
    
	maxlen = 0;
    for lege = leg
        maxlen = max(maxlen, length(lege{:}));
    end

    maxlen++;
    fmt = sprintf('%%.%ds', maxlen); % formato de print limitante (corta os espaçoes a mais do prox fmt) do título
    fmt2 = sprintf('%%-%ds', maxlen+3); % formato de print da legenda, preenche a saída com espaços em branco
    fmt3 = sprintf('%%-%d.%df', maxlen, n); % formato de print dos dados
	sep = repmat(['-'], 1, maxlen+1);

    for i=1:length(A(1,:)) % primeira linha de ------
		fprintf( '%s', sep );
	end
    fprintf( '\n' );
    
    for lege = leg % print da legenda no formato array de cell
        fprintf(fmt, sprintf(fmt2, lege{:}), '|');
    end
    fprintf( '\n' );

    for i=1:length(A(1,:)) % secunda linha de ------
		fprintf( '%s', sep );
	end
    fprintf('\n');

    for j = 1:length(A(:,1)) % print dos dados da tabela
        for i = 1:length(A(1,:))
            fprintf(fmt, sprintf(fmt3, A(j,i)), '|');
        end
        fprintf('\n');
    end

    for i=1:length(A(1,:)) % print da separação final
		fprintf( '%s', sep );
	end
    fprintf('\n');

end