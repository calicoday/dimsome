# #! ruby

# The testing module
require_relative 'porkbelly.rb'

# The test setup
require_relative '../spec/helpers/leader.rb'

# The tests
require_relative '../spec/whirlwind_spec.rb'
require_relative '../spec/xdim2d_spec.rb'
require_relative '../spec/xmod_util_spec.rb'
require_relative '../spec/xmod_arith_spec.rb'
require_relative '../spec/xpoint_spec.rb'
require_relative '../spec/xsize_spec.rb'
require_relative '../spec/xrect_spec.rb' 
require_relative '../spec/xrect_rel_spec.rb' 
require_relative '../spec/xrect_grip_spec.rb'

Porkbelly.report_summary
