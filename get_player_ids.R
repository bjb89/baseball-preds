batting = read.csv('raw_data/batting.csv')
bstartyr = aggregate(batting$year, list(player_id = batting$player_id), min)
bendyr = aggregate(batting$year, list(player_id = batting$player_id), max)

colnames(bstartyr) = c('player_id', 'startyr')
colnames(bendyr) = c('player_id', 'endyr')

bcareer_spans = merge(bstartyr, bendyr)

bspans_post1970 = bcareer_spans[bcareer_spans$startyr >= 1970,]
bfas_post1970 = with(bspans_post1970, bspans_post1970[endyr - startyr >= 5,])


pitching = read.csv('raw_data/pitching.csv')
pstartyr = aggregate(pitching$year, list(player_id = pitching$player_id), min)
pendyr = aggregate(pitching$year, list(player_id = pitching$player_id), max)

colnames(pstartyr) = c('player_id', 'startyr')
colnames(pendyr) = c('player_id', 'endyr')

pcareer_spans = merge(pstartyr, pendyr)

pspans_post1970 = pcareer_spans[pcareer_spans$startyr >= 1970,]
pfas_post1970 = with(pspans_post1970, pspans_post1970[endyr - startyr >= 5,])

fas_post1970 = unique(rbind(bfas_post1970, pfas_post1970))

write.csv(fas_post1970, file = '1970fas.csv', row.names=FALSE)
