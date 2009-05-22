#--
# mysql.rb
#
# Copyright (C) 2009 GemStone Systems, Inc. All rights reserved.
#
#++

# = Overview
#
# This script shows basic usage of the MySQL driver provided with MagLev.
#
# To run the script, ensure you have MySQL running, and edit the variables
# for your configuration.


require 'ruby-mysql/mysql'

# CONFIGURATION
host = 'localhost'
user = 'webuser'
pass = 'webuser'

my = Mysql.new(host, user, pass)
my.query("create database test_db")

puts "Created database"
my.select_db "test_db"

puts "Database test_db selected"
my.query("create table data(id int not null, str char(32) not null)")
puts "Table created"
my.query("insert into data (id, str) values (1, 'foo')")
my.query("insert into data (id, str) values (2, 'bar')")
puts "Rows inserted"
res = my.query("select * from data")
if res.num_rows != 2 then raise "num_rows: failed" end
if res.fetch_row != ["1", "foo"] then raise "fetch_row: failed" end
if res.fetch_hash != {"id"=>"2", "str"=>"bar"} then raise "fetch_hash: failed" end
puts "Select complete"
my.query("update data set id=0, str='hoge'")
if my.affected_rows != 2 then raise "update: failed" end
puts "Update complete"
my.query("drop table data")
puts "Tabled dropped"
my.query("drop database test_db")
puts "Database test_db dropped"
my.close
puts "Connection closed"
