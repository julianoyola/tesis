function Q=quant2(V,X,Y)
%cuantiza la matriz V segun el cuantizador definido en X,Y

[dy,dx]=size(V);
Q=zeros(dy,dx);
map=zeros(1,max(max(V))+1);

for i=1:length(map)
	map(i)=quant0(i,X,Y);
end

for i=1:dx
	for j=1:dy
		p=V(j,i)+1;
		if p>length(map)
			p
			%pause;
		end
		p=map(p);
		Q(j,i)=p;
	end
end
