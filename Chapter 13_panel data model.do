set more off
log using ex13.log, replace

import excel "E:\TableFile\statadatas\wlstata\mooc\13\fatality2.xls", sheet("fatality") firstrow

gen fatarate=mrall*1000
reg fatarate beertax,r

xtset state year
*表示设置固定效应，即i和t
xtreg fatarate beertax, fe vce(cluster state)
*聚类是为了消除自相关
reg fatarate beertax i.state, vce(cluster state)
*i.state表示加入虚拟变量
xtreg fatarate beertax i.year, vce(cluster state)
reg fatarate beertax i.year i.state, vce(cluster state)

xtreg fatarate beertax i.year, fe vce(cluster state)
testparm i.year

*Hausman检验
xtreg fatarate beertax,fe
estimate store fe
xtreg fatarate beertax, re
estimate store re
hausman fe re

log close
exit
