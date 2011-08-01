
require 'relations'
require 'entity'
require "connection"
require 'bytecode'
require 'class_parser'
require 'rubygems'
require 'smart_colored'
require 'smart_colored/extend'
require 'ap'

require 'java'


module Rubernate
  class Init
      attr_accessor :connection, :bytecode, :parser,:hibernate_classes
      
    def initialize
      self.hibernate_classes = []
      
      load_jars      
      bytecode_provider
      
    end
    
    def load_jars
      Dir["../../native/lib/*.jar"].each do |file|
          puts "Loading: #{file}".green
          require file
      end      
    end
    
    def load_classes(*classes)
      classes.each do |clazz|
        self.hibernate_classes << ClassParser.new(clazz,self.bytecode).to_class
      end
      
      
    end

    def connect
      self.connection= Connection.new(self.hibernate_classes)
      self.connection.connect
      self.connection.get_session
    end
    
    def bytecode_provider
      self.bytecode ||= Bytecode.new
      self.bytecode
    end

  end
end

class Group < Rubernate::Entity
  integer :id , :id=>true , :generated => [:auto=>true, :strategy=>:auto]
end

class User < Rubernate::Entity
  integer :id , :id=>true , :generated => [:auto=>true, :strategy=>:auto]
  one_to_one :fucks , :class=>"org.devmask.Sistema"
  many_to_one :group, :class=>"Group"
end

rubernate = Rubernate::Init.new
rubernate.load_classes(Group,User)
rubernate.connect

