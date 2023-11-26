
set more off
log using ex14.log, replace

*注意：请把下面双引号里换成实际的数据文件存放地?
use "E:\TableFile\statadatas\wlstata\mooc\14\hmda_sw.dta", clear
logit deny PIratio,r
logit deny PIratio black,r
probit deny PIratio black,r

sca z1 = _b[_cons]+_b[PIratio]*.3+_b[black]*0
display normprob(z1)

sca z2 = _b[_cons]+_b[PIratio]*.3+_b[black]*1
display normprob(z2)

predict denyhat

gen yaht= (denyhat>=0.5 & deny==1)|(denyhat<0.5 & deny==0)
egen correctratio=mean(yaht)
display correctratio

log close
exit
