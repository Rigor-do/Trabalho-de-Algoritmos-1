% Imprimir tabela A, sendo a matriz A composta por: primeira linha os títulos e a secunda linha 
% 	Exemplo printTabX( X, 'X', '%5.2f', 'Tabela X-Y' )
%
function printTabA( A, leg, formstr, titulo)
	fprintf('%s\n', titulo );
    
	maxlenX = 0;
    for lege = leg
        maxlenX = max(maxlenX, length(lege{:}));
    end

    maxlenX++;
    maxlenX

	sep = repmat(['-'], 1, maxlenX+5);

    for i=1:length(A(1,:))
		fprintf( '%s', sep );
	end

    fprintf( '\n' );

    for lege = leg
        buf = sprintf('%s', lege{:});
       % fprintf('buf%d = %s', lege{:}, buf);
        fmt = sprintf('%%%ds', maxlenX);
        fprintf(fmt, buf, '|');
    end

    fprintf('\n');

    for i=1:length(A(1,:))
		fprintf( '%s', sep );
	end

    fprintf('\n');

    for j = 1:length(A(:,1))
        for i = 1:length(A(1,:))
            buf = sprintf(formstr, A(j,i));
		    fmt = sprintf('%%%ds', maxlenX);
		    fprintf( fmt, buf , '|');
        end
        fprintf('\n');
    end

    for i=1:length(A(1,:))
		fprintf( '%s', sep );
	end

    fprintf('\n');

    % maxlen = max(length(A(1,:)));
	% namestr = sprintf('%%%ds%%2s', maxlen+1 );
    % maxlenX = 0;
    % for i=1:length(A(1,:))
    %     maxlenX = max(maxlenX, length(sprintf(formstr, A(1,:))));
    % end
    % sep = repmat(['-'], 1, maxlenX+2);
    % fprintf( '%s', sep1 );
	
    
    
    % for i=1:length(A(1,:))
    %     buf = sprintf(formstr, X(1,:));
    %     fmt = sprintf('%%%ds', maxlenX+2 );
	% 	fprintf( fmt, buf );
	% end
    
    % fprintf( '\n%s', sep1 );
	
    % for i=1:length(X)
	% 	fprintf( '%s', sep );
	% end
	
    % fprintf('\n\n');
end