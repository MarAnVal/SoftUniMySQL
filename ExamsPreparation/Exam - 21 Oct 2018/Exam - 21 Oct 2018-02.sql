UPDATE journeys
-- those journeys’ purpose, which meet the following conditions:
set purpose = (
case 
-- If the journey’s id is dividable by 2 without remainder – ‘Medical’.
when id % 2 = 0 then 'Medical'
-- If the journey’s id is dividable by 3 without remainder – ‘Technical’.
when id % 3 = 0 then 'Technical'
-- If the journey’s id is dividable by 5 without remainder – ‘Educational’.
when id % 5 = 0 then 'Educational'
-- If the journey’s id is dividable by 7 without remainder – ‘Military’. 
when id % 7 = 0 then 'Military'
else purpose
end);