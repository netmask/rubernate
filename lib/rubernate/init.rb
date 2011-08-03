
require 'rubernate/relations'
require 'rubernate/entity'
require "rubernate/connection"
require 'rubernate/bytecode'
require 'rubernate/class_parser'

require 'java'
require 'rubygems'

module Rubernate
  class Init
      attr_accessor :connection, :bytecode, :parser,:hibernate_classes
      
    def initialize
      self.hibernate_classes = []
                  
      bytecode_provider
      
    end
    
    
    def load_classes(*classes)
      classes.each do |clazz|
        self.hibernate_classes << ClassParser.new(clazz,self.bytecode).to_class
      end
      
      
    end

    def connect(connection)      
      self.connection= Connection.new(connection, self.hibernate_classes)
      self.connection.entity_manager_factory
    end
    
    def bytecode_provider
      self.bytecode ||= Bytecode.new
      self.bytecode
    end

  end
end


