#########################################################################################
##  Parameters taken as given



param nI integer;
set I = 1..nI;

param wRaw {I};
param F {I};

# Read in data
read nI, {i in I} (wRaw[i], F[i]) < mirrlees_data.txt;

param w {i in I} = wRaw[i]*10;

param sigma  := 2;
param ETI := 0.25;
param k := 1/ETI;
param paretoRatio = 1.5;
param mtrTop = 0.4;

param fTop = 1 - F[nI];


#########################################################################################
##  Optimization variables

var c {I} >= 0;
var y {I} >= 0;


#########################################################################################
## Auxiliary variables (pinned down by above variables)

var f {i in I} = if i=1 then F[1] else F[i] - F[i-1];

var util {i in I} = log(c[i] - (y[i]/w[i])^(1+k)/(1+k)); # Saez type I
var utilDown {i in 2..nI} = log(c[i-1] - (y[i-1]/w[i])^(1+k)/(1+k)); # Saez type I
var mvc {i in I} = 1/(c[i] - (y[i]/w[i])^(1+k)/(1+k));
var mtr {i in I} = 1 - y[i]^k/w[i]^(k+1);

# var util {i in I} = log(c[i]) - (y[i]/w[i])^sigma/sigma;
# var utilDown {i in 2..nI} = log(c[i-1]) - (y[i-1]/w[i])^sigma/sigma;
# var mvc {i in I} = 1/c[i];
# var mtr {i in I} = 1 - c[i]*y[i]^(sigma-1)/w[i]^sigma;

var mvpf = 1/(sum {i in I} f[i]/mvc[i]);
var gweights {i in I} = mvc[i]/mvpf;

var atr {i in I} = (y[i] - c[i])/y[i];

var surplus = sum {i in I} f[i]*(y[i] - c[i]);


#########################################################################################
##  Describe objective functions and constraints

maximize SWF: sum {i in I} f[i]*util[i];

subject to
    ICconstr {i in 2..nI}: util[i] = utilDown[i];
    BudgetConstraint: surplus = 0;
    yIncr {i in 2..nI}: y[i] >= y[i-1];
