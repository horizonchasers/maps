require 'mongo'
require './model/mongoModule'
require './model/user'
require './model/venue'
require './model/checkin'

if ENV['RACK_ENV'] == 'production'
  db = URI.parse('mongodb://webuser:tinga@172.31.44.116:27017/maps')
  db_name = db.path.gsub(/^\//, '')
  DB = Mongo::Connection.new(db.host, db.port).db(db_name)
  DB.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
else
  DB = Mongo::Connection.new("localhost", 27017).db('maps')
end

USERS      = DB['users']
VENUES     = DB['venues']
CHECKINS   = DB['checkins']
VENUES.ensure_index([["location.geo", Mongo::GEO2D]])
