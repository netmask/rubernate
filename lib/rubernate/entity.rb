require 'relations'
require 'java'
module Rubernate
  class Entity < java.lang.Object
    include Relations
    
    attr_accessor :proxy_class
    
    def self.find()
     
    end
    
    def self.all()
      
    end
  end
end
