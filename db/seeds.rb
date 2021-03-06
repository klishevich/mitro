# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# lkjlkjlk

puts 'Delete OrderItems'
OrderItem.delete_all

puts 'Delete Orders'
Order.delete_all

puts 'Delete and Create OrderStatuses'
OrderStatus.delete_all
OrderStatus.create! id: 1, name: "В процессе"
OrderStatus.create! id: 2, name: "Размещен"
OrderStatus.create! id: 3, name: "Завершен"
OrderStatus.create! id: 4, name: "Отменен"
OrderStatus.create! id: 5, name: "Оплачен Я.К."

# puts 'Delete Categories'
# puts 'Create Categories'
# Category.delete_all
# Category.create([
#     { 
#         name: "Кофе", 
#         code: "coffee",
#         order: 1,
#     },
#     { 
#         name: "Бургеры",
#         code: "burger", 
#         order: 2,
#     },
#     { 
#         name: "Картошка",
#         code: "potato", 
#         order: 3,
#     },
# ])

# puts 'Create Products'
# Product.create([
#   { 
#   	name: "Кофе Латте", 
#     description: "Хороший кофе", 
#     price: 99,
#     volume: "200 мл",
#     is_delivery: true,
#     is_sibirskaya: true,
#     is_volochaevskaya: true,
#     is_foodtrack: true
#   },
#   { 
#   	name: "Кофе Сибирский", 
#     description: "Хороший кофе", 
#     price: 199,
#     volume: "200 мл",
#     is_delivery: false,
#     is_sibirskaya: true,
#     is_volochaevskaya: false,
#     is_foodtrack: false
#   },
#   { 
#   	name: "Кофе Волочаевский", 
#     description: "Хороший кофе", 
#     price: 199,
#     volume: "200 мл",
#     is_delivery: false,
#     is_sibirskaya: false,
#     is_volochaevskaya: true,
#     is_foodtrack: false
#   },
#   { 
#   	name: "Сэндвич с беконом", 
#     description: "Сытный", 
#     price: 150,
#     volume: "300 гр",
#     is_delivery: true,
#     is_sibirskaya: true,
#     is_volochaevskaya: true,
#     is_foodtrack: true
#   }
# ])
