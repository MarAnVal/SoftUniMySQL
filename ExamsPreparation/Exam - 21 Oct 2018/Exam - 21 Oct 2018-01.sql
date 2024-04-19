INSERT into travel_cards (card_number, job_during_journey, colonist_id, journey_id)
-- insert data in the travel_cards table with the following values:
select (
-- For colonists born after ‘1980-01-01’, the card_number must be combination between the year of birth, day and the first 4 digits from the ucn.
-- For the rest – year of birth, month and the last 4 digits from the ucn.
case 
when c.birth_date > '1980-01-01' then concat_ws('', year(c.birth_date), day(c.birth_date), left(c.ucn, 4)) 
else concat_ws('', year(c.birth_date), month(c.birth_date), right(c.ucn, 4))
end
) as card_number,
(
-- For colonists with id that can be divided by 2 without remainder, job must be ‘Pilot’, 
-- for colonists with id that can be divided by 3 without remainder – ‘Cook’, and everyone else – ‘Engineer’.
case 
when c.id % 2 = 0 then 'Pilot'
when c.id % 3 = 0 then 'Cook'
else 'Engineer'
end
) as job_during_journey,
c.id as colonist_id,
(
-- Journey id is the first digit from the colonist’s ucn.
left(c.ucn, 1)
) as journey_id
 from colonists as c
 -- For colonists with id between 96 and 100(inclusive)
 where c.id between 96 and 100;

