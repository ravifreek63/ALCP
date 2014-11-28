%This m-file demonstrates how to read and write a simple ascii file 
%in MATLAB using the low level file I\O routines
function writeToFile(Sn, file)
%write the data file
fid = fopen(file, 'wt');  %open the file
fprintf(fid, '%s\n', 'This is a square matrix');   %write the header
fprintf(fid, '%f\t%f\t\n',Sn');   %write data to file
fclose(fid);   %close file

