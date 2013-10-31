function plot_mirrlees_results()
global FIGUREDIR;
FIGUREDIR = '';

fname = 'ampl_output.txt';
[~,w,c,y,atr,mtr] = importfile(fname);

S = 1e-4;
yScaled = (y*1e5)*S;
plot(yScaled,mtr);
ylim([0 1]);
xlim([min(yScaled) max(yScaled)]);
xlim([min(yScaled) 500]);

xlabel('income (in 100,000s)');
ylabel('mtr');

save_eps('mtr_schedule');

end


function [Index_1,w,c,y,atr,mtr] = importfile(filename, startRow, endRow)

delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

formatSpec = '%f%f%f%f%f%f%[^\n\r]';

fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

fclose(fileID);

Index_1 = dataArray{:, 1};
w   = dataArray{:, 2};
c   = dataArray{:, 3};
y   = dataArray{:, 4};
atr = dataArray{:, 5};
mtr = dataArray{:, 6};

end


function save_eps(filename)
global FIGUREDIR;
saveas(gca,[FIGUREDIR filename '.eps'],'eps2c');
end 