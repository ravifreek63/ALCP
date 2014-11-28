function Output = readFromFile(file)
%read the file back in
fid=fopen(file, 'rt');   %open the file
title = fgetl(fid);  %read in the header
Output = fscanf(fid, '%g %g', [2 inf])  ;  % It has two rows now.
Output = Output';
fclose(fid);   %close the file