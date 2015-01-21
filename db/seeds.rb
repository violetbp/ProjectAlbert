# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Group.create(title: 'Welcome!', explanation: 'This is a demo group.', teacher: 'Dr. Example')
Problem.create(title: 'Example Problem 1', explanation: 'Read from standard input. If you read \"Help!\" print \"I\'ll save you!\". If you read \"I\'m fine.\" print \"Okay.\"',
  exIn: 'Help!\nI\'m fine.', exOut: 'I\'ll save you!\nOkay.', points: 5)
Problemset.create(title: 'Example Problems', explanation: 'Example problemset.')