module Rubernate
  
  # This utilit  class creates the java 'classes' 
  class Bytecode
    require 'java'
        
    def initialize      
      @@mapped_types = Hash[:integer => "Integer" ,
                        :long => "Long",
                        :short => "Short",
                        :float => "Float",
                        :double => "Double",
                        :string => "String" ,
                        :char => "Character",
                        :boolean=> "Boolean"]
                        
    end
    
    class << self       
      def mapped_types
        @@mapped_types
      end
    end
    
    # Creates a new class
    # @param[String] class name
    # @returns[ProxyClass]
    def create_class(name)                              
      AsmProxyClass.new(name)
    end  
  end
end