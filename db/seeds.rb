# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create( :account => 'radiusadmin',
             :username => 'radius 管理者', 
             :email => 'radius@ep.sci.hokudai.ac.jp', 
             :role_id => 1,
             :grade => 'S1',
             :password_digest => '$2a$10$0SQ3gTNdsdoLJlwa8bhxdeKPwmN5Bbeke2X8XFhdJy3VmceoJ.mx6',
             :acception => 't',
             :owner => 'radiusadmin'
             )

Role.create do |u| 
  u.position = 'Staff'
end
Role.create do |u| 
  u.position = '学生'
end
Role.create do |u| 
  u.position = '訪問者'
end

