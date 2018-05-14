function [datos] = FiltroMedia(X, W)
    
    %SIDE ELEMENTS AMOUNT
    ne_sides=floor(W/2);

    %FIRST ELEMENTS 
    for i = 1:ne_sides
        datos(i)=sum(X(1:(i+ne_sides)))/(i+ne_sides);
    end
    
    %MID ELEMENTS
    for i = (ne_sides+1):(size(X,2)-ne_sides)
        datos(i)=sum(X((i-ne_sides):(i+ne_sides)))/W;
    end
    
    %LAST ELEMENTS
    for i = (size(X,2)-ne_sides+1):size(X,2)
        datos(i)=sum(X(i-ne_sides:size(X,2)))/(ne_sides+size(X,2)-i+1);   
    end

end

