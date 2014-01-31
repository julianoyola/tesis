function [bins,repet] = histog2(matt)
%
%	function [bins,repet] = my_histog(matt)
%
% Dada una matriz/vector, retorna el histograma de sus valores, donde bins corresponde
% a cada valor de la matriz y repet a sus respectivas repeticiones. Ideal para
% luego ejecutar la sentencia bar(bins,repet)!
% (notar que redondeo los valores!)

	v = round(matt(:));
	[bins,i,j] = unique(v);	
	repet = histc(j,1:length(bins));
