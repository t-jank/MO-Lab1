set cities;
set cranes;
set universal_cranes;

param transport_cost{cranes} >= 0;
param distances{cities, cities} >= 0;
param deficit{cities, cranes} >= 0;
param excess{cities, cranes} >= 0;

var x{cities, cities, cranes} >= 0; #, integer;

minimize obj: sum{source_city in cities, target_city in cities, crane in cranes}
  x[source_city, target_city, crane] * distances[source_city, target_city] * transport_cost[crane];

# move all excessive cranes
subject to move_everything{source_city in cities, crane in cranes}:
  sum{target_city in cities} x[source_city, target_city, crane] == excess[source_city, crane];

# allow substituting  type 1 with type 2
subject to universal_crane{target_city in cities, shared_crane in universal_cranes}:
  sum{source_city in cities} x[source_city, target_city, shared_crane] >= deficit[target_city, shared_crane];

# satisfy all deficit
subject to overall_deficit{target_city in cities}:
  sum{source_city in cities, crane in cranes} x[source_city, target_city, crane] == sum{crane in cranes}deficit[target_city, crane];

solve;

printf "Overall cost: %f\n", sum{source_city in cities, target_city in cities, crane in cranes}
  x[source_city, target_city, crane] * distances[source_city, target_city] * transport_cost[crane];

for {source_city in cities} {
  for {target_city in cities} {
    for {crane in cranes} {
      printf if x[source_city, target_city, crane] == 0 then "" else "Move %d %s cranes from %s to %s\n", x[source_city, target_city, crane], crane, source_city, target_city;
    }
  }
}

data;

set cities := Opole Brzeg Nysa Prudnik Strzelce Kozle Raciborz;

set cranes := Type1 Type2;

# cranes than can substitute any others
set universal_cranes := Type2;

param transport_cost :=
  Type1 1.0
  Type2 1.2;

param distances: Opole Brzeg Nysa Prudnik Strzelce Kozle Raciborz :=
  Opole 0 43 57 51 34 49 79
  Brzeg 43 0 53 80 99 95 125
  Nysa 57 53 0 30 95 72 90
  Prudnik 51 80 30 0 68 44 62
  Strzelce 34 99 95 68 0 26 61
  Kozle 49 95 72 44 26 0 36
  Raciborz 79 125 90 62 61 36 0;

param deficit: Type1 Type2 :=
  Opole    0  2
  Brzeg    10 0
  Nysa     0  0
  Prudnik  4  0
  Strzelce 0  4
  Kozle    8  2
  Raciborz 0  1;

param excess: Type1 Type2 :=
  Opole    7  0
  Brzeg    0  1
  Nysa     6  2
  Prudnik  0  10
  Strzelce 5  0
  Kozle    0  0
  Raciborz 0  0;
