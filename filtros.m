function [ b ] = filtros( a )
    [fil,col,cap]=size(a);
    if cap>1;b=a; return ; end
    h = fspecial('average');
    a1 = imfilter(a,h);
    h = fspecial('disk',10);
    a2 = imfilter(a,h);
    h = fspecial('gaussian');
    a3 = imfilter(a,h);
    a4 = medfilt2(a);
    %b = [a1,a2,a3,a4];
    b = a2;
end

