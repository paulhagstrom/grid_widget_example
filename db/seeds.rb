# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

authors = Author.create([
  {:name => 'Chomsky, Noam'},
  {:name => 'Carnie, Andrew'},
  {:name => 'Puzo, Mario'},
  {:name => 'Goldman, William'},
  ]).inject({}) {|h,author| h[author.name] = author.id; h}

books = Book.create([
  {:title => "The Minimalist Program", :price => 40, :author_id => authors['Chomsky, Noam'], :read => true},
  {:title => "Lectures on Government and Binding", :price => 60, :author_id => authors['Chomsky, Noam'], :read => false},
  {:title => "Syntax", :price => 40, :author_id => authors['Carnie, Andrew'], :read => true},
  {:title => "The Godfather", :price => 8, :author_id => authors['Puzo, Mario'], :read => false},
  {:title => "The Princess Bride", :price => 8, :author_id => authors['Goldman, William'], :read => true},
  ]).inject({}) {|h,book| h[book.title] = book.id; h}
