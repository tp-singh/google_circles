# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Employee.delete_all
Employee.create(first_name: 'John', last_name: 'Muller', email: 'john@goorange.nl', is_active: true)
Employee.create(first_name: 'Kyle', last_name: 'Reese', email: 'kyle@goorange.nl', is_active: true)
Employee.create(first_name: 'Pinto', last_name: 'Smith', email: 'pinto_smith@goorange.nl', is_active: true)
