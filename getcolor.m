function  x = getcolor(count)
    switch count
        case 1
            x = 'r';   
        case 2
            x = 'g'; 
        case 3
            x = 'b'; 
        case 4
            x = 'y'; 
        case 5
            x = 'm'; 
        otherwise
            x = 'k'; 
    end 