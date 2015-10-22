# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Like.destroy_all
User.destroy_all
Post.destroy_all
Comment.destroy_all
Tag.destroy_all

users = []

users << User.create(
  name: 'Pato',
  last_name: 'Campos',
  username: 'Patocarlo',
  email: 'admin@admin.com',
  password: 'voronwe364',
  role: 0
)
users << User.create(
  name: 'Alfredo',
  last_name: 'Lobos',
  username: 'Fio',
  email: 'editor@editor.com',
  password: 'voronwe364',
  role: 1
)
users << User.create(
  name: 'Eduardo',
  last_name: 'Cornejo',
  username: 'Eddie',
  email: 'basic@basic.com',
  password: 'voronwe364',
  role: 2
)

tag = []

tag << Tag.create(name: 'Pelambre')
tag << Tag.create(name: 'Sexo')
tag << Tag.create(name: 'Social')
tag << Tag.create(name: 'Ayuda')
tag << Tag.create(name: 'Consejos')
tag << Tag.create(name: 'Adultos')
tag << Tag.create(name: 'Musica')
tag << Tag.create(name: 'Mujeres')
tag << Tag.create(name: 'Hombres')
tag << Tag.create(name: 'Webadas')