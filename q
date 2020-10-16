
[1mFrom:[0m /home/geodevadmin/programming/ruby/political_fingerprint_api/app/controllers/counties_controller.rb:51 CountiesController#counties_by_state:

    [1;34m40[0m: [32mdef[0m [1;34mcounties_by_state[0m
    [1;34m41[0m:   
    [1;34m42[0m:   states = [1;34;4mCounty[0m.all.group_by{ |county| county.state_name }.sort_by{ |state| state }
    [1;34m43[0m: 
    [1;34m44[0m:   return_array = []
    [1;34m45[0m: 
    [1;34m46[0m:   states.each { |state|
    [1;34m47[0m:     st = {}
    [1;34m48[0m:     st[[31m[1;31m'[0m[31mname[1;31m'[0m[31m[0m] = state[[1;34m0[0m]
    [1;34m49[0m:     st[[31m[1;31m'[0m[31mcounties[1;31m'[0m[31m[0m] = []
    [1;34m50[0m: 
 => [1;34m51[0m:     binding.pry
    [1;34m52[0m:     
    [1;34m53[0m:     return_array.push(st)
    [1;34m54[0m: 
    [1;34m55[0m:   }
    [1;34m56[0m: 
    [1;34m57[0m:   [1;34m# .sort_by{ |county| county.state_abbrev }[0m
    [1;34m58[0m:   render [35mjson[0m: return_array
    [1;34m59[0m: [32mend[0m

