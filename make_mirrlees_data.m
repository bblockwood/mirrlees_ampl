function make_mirrlees_data()

upper_tail_ratio = 2;
pareto_param = upper_tail_ratio/(upper_tail_ratio - 1);

z = [pareto_param 6 0.2];

lo = 100; hi = 10000;
wvec = logspace(log10(lo),log10(hi),100)';
F = plogncdf(wvec,z(1),z(2),z(3));

zFrac = 0.01;
F = zFrac + (1-zFrac)*F; % place mass on zero

wvec = wvec*1e-3; 

fname = 'mirrlees_data.txt';
dlmwrite(fname,length(F),' ');
dlmwrite(fname,[wvec F],'-append','delimiter',' ');

end
