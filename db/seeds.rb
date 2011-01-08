# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

authors = Author.create([
  {:name => 'Noam Chomsky'},
  {:name => 'Andrew Carnie'},
  ]).inject({}) {|h,author| h[author.name] = author.id; h}

books = Book.create([
  {:title => "The Minimalist Program", :price => "40.00", :author_id => authors['Noam Chomsky']},
  {:title => "Lectures on Government and Binding", :price => "60.00", :author_id => authors['Noam Chomsky']},
  {:title => "Syntax", :price => "40.00", :author_id => authors['Andrew Carnie']},
  ]).inject({}) {|h,book| h[book.title] = book.id; h}
