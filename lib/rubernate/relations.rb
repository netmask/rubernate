module Rubernate
  module Relations
    class << self
      def included(base)
         base.extend ClassMethods
       end
    end

    module ClassMethods
      #Defines a 'basic' Supporte tipes
      @@supported_types = [:integer,:long,:short,:float,:double,:string,:char,:boolean]
      @@supported_associations = [:one_to_one,:one_to_many,:many_to_one,:many_to_many]
      
      #TODO merge to a single loop ;) i love ruby
      @@supported_types.each do | function |
        method = "#{function}".to_sym        
        send :define_method, method do |name,*arguments| 
          add_field(name,function,arguments)
        end                
      end
      
      @@supported_associations.each do |function|
        method = "#{function}".to_sym
        send :define_method, method do |name,*arguments|
          map = arguments.first
          add_relation(name,map.delete(:class),function,arguments) if map != nil
        end
      end 
      
      def bind_class(clazz)
        @from_java_class = clazz
      end
      
      def fields
        @fields
      end
      
      def relations
        @relations
      end
      
      def add_field(name,type,*args)
        @fields ||= []        
        @fields << Hash[:name=>name,:type=>type,:args=>args]
      end
      
      def table_name
        @table_name
      end
      
      def table_name=(table_name)
        @table_name=table_name
      end
      
      def add_relation(name,clazz,type,params)
        @relations ||= []
        @relations << Hash[:name=>name,:class=>clazz,:type=>type,:params=>params]
      end
      
      def supported_types
        @@supported_types
      end
      
      def supported_associations
        @@supported_associations
      end

    end
    
  end
end