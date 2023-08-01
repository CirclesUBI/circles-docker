#!/bin/bash

set -e
docker exec -it circles-db psql -U postgres -d api -c "insert into news (message_en, date, \"iconId\", \"isActive\") values
('News 1', '2022-10-01', 99131232, true),
('News 2', '2022-12-01', 00131232, true),
('News 3', '2023-03-01', 22131232, true),
('News 4', '2023-04-01', 33131232, true),
('News 5', '2023-05-11', 44131232, true),
('News 6', '2022-06-12', 55131232, false),
('News 7', '2022-07-20', 66131232, true),
('News 8', '2022-08-21', 77131232, false),
('News 9', '2022-09-22', 88131232, true) ;"
