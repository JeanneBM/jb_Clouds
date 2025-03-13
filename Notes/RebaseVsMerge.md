W przypadku rebase cała historia commitów z gałęzi „feature” (tej, którą rebasujesz) zostaje „dopisana” do historii głównej gałęzi (np. main). To sprawia, że historia jest liniowa i każdy commit z „feature” wygląda, jakby pierwotnie powstał na „main”.

Natomiast przy merge, zamiast przenosić całą historię commitów do „main”, tworzony jest specjalny merge commit, który po prostu wskazuje, że dwie gałęzie zostały scalone. Historia commitów gałęzi „feature” pozostaje oddzielona.
