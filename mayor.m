function[b]= mayor(a)
    [fil,col,cap] = size(a);
    if cap>1;b=a;return;end
    [l,n]=bwlabel(a);
    areat=[]; 
    c=a*0;
        for i=1: n
            c(l==i)=1;
            area = sum(c(:));
            areat = [areat,area];
            c = a*0;
        end
    d = max(areat(:));
    b=a*0;
    d=find(areat==d);
    b(l==d)=255;
end

