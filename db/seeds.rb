# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
Plan.create([
  {name: 'Basic'  , channels_quantity: 100 },
  {name: 'Medium' , channels_quantity: 20  },
  {name: 'Premium', channels_quantity: 100 }
])
#   Mayor.create(name: 'Emanuel', city: cities.first)
