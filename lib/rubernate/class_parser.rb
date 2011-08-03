module Rubernate
  
  class ClassParser
    
    attr_accessor :clazz,:bytecode,:proxy_class
    
    def initialize(clazz,bytecode)
      puts "Class"
      self.clazz = clazz  
      self.bytecode = bytecode
      self.proxy_class = bytecode.create_class(name)      
      initialize_simples
    end
    
    #TODO need to correct this behaivor
    def initialize_simples
      clazz.fields.each do |field|
        proxy_field = proxy_class.add_simple(field[:type],field[:name].to_s)
        field[:args].each do |f1|
          if f1.length > 0
            build_id_for proxy_field if f1[0][:id]
          end
        end
      end
    end
    
    def build_id_for(field)
      self.proxy_class.add_annotation field,"javax.persistence.Id"
    end
    
    
    
    def name
      self.clazz.name
    end
    
    def to_class
      self.proxy_class.to_class
    end
    
  end
  
end