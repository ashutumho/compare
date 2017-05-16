load iddata1 z1;
sys = ssest(z1,3);
opt = compareOptions('InitialCondition','z');
compare(z1,sys,opt);