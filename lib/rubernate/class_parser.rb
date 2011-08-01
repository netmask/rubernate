module Rubernate
  
  class ClassParser
    
    attr_accessor :clazz,:bytecode,:proxy_class
    
    def initialize(clazz,bytecode)
      self.clazz = clazz  
      self.bytecode = bytecode
      self.proxy_class = bytecode.create_class(name)      
      initialize_simples
    end
    
    #TODO need to correct this behaivor
    def initialize_simples
      clazz.fields.each do |field|
        proxy_class.add_simple(field[:type],field[:name].to_s)
        field[:args].each do |f1|
          ap f1[0][:id]
        end
      end
    end
    
    def name
      self.clazz.name
    end
    
    def to_class
      self.proxy_class.to_class
    end
    
  end
  
end