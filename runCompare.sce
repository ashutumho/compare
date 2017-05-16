// with iddata function
plantData = iddata(yy,uu,0.1)
compare(plantData,sys)
// other output datas
[x0] = compare(plantData,sys)
[fit x0] = compare(plantData,sys)
[y fit x0] = compare(plantData,sys)

