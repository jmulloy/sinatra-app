require './config/environment'



use Rack::MethodOverride
use ListsController
use UsersController
run ApplicationController
