### To run the specs: ./dragonruby dragon_dimsome_demo --no-tick

# The Dimsome classes
require 'dragon_dimsome/dragon_dimsome.rb'

# The testing module
require 'dragon_dimsome/porkbelly.rb' 

# The test setup
require 'spec/helpers/leader.rb'

# The tests
require 'spec/whirlwind_spec.rb'

require 'spec/xdim2d_spec.rb'
require 'spec/xmod_util_spec.rb'
require 'spec/xmod_arith_spec.rb'
require 'spec/xpoint_spec.rb'
require 'spec/xsize_spec.rb'
require 'spec/xrect_spec.rb' 
require 'spec/xrect_rel_spec.rb' 
require 'spec/xrect_grip_spec.rb'


# The tests are run as they are read, just put out the summary now and quit.
Porkbelly.report_summary
exit(0)

# tick won't get called at all if we run with --no-tick, otherwise the main screen 
# will flash up briefly. Either way, the app exits once the tests are done.
def tick args
  args.outputs.labels << [ 580, 500, 'Hello World!' ]
  args.outputs.labels << [ 475, 150, '(Consider reading README.txt now.)' ]
  args.outputs.sprites << [ 576, 310, 128, 101, 'dragonruby.png' ]
end

