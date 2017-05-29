// solid time
yData = []
xData = []
solid = 0:1:1
slopSolid = 10
//y=mx
solidY = slopSolid*solid
xData = [xData solid]
yData = [yData solidY] 
melting = solid($):1:10;
meltY = ones(1,length(melting))*solidY($)
xData = [xData melting];
yData = [yData meltY]
liquid = 0.1:0.1:1
//y=mx
slopLiquid = 12
liquidY = liquid*slopLiquid*yData($)
xData = [xData melting($):0.1:melting($)+1-0.1]
yData = [yData liquidY]
plot2d(xData,yData)

