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
    
    # Representation of the generated class
    class ProxyClass

        attr_accessor :clazz, :ct_class, :frozen, :class_file, :const_pool

        def initialize(ct_class)
          self.ct_class = ct_class
         
          self.class_file.addAttribute(ann_attr)                    
        end
        
        # adds full qulified java annotation to a field
        # @param[CtField] javassist field
        # @param[String] field name
        def add_annotation(field,name)
          ann_attr = AnnotationsAttribute.new(self.const_pool, AnnotationsAttribute.visibleTag)
          ann = Annotation.new(name,self.const_pool)
          
          ann_attr.set_annotation ann
          field.getFieldInfo.addAttribute ann_attr
        end
        
        # add simple parameter to a field
        # (see #add_parameter)
        def add_simple(type,name)
          add_parameter(Rubernate::Bytecode.mapped_types[type],name)
        end
        
        
        # This wild add a parammeter to given class and generates te setter
        #
        # @param[String] java type 
        # @Param[String] name of the field
        # @return[CtField] Generated field
        def add_parameter(type,name)
           java_import 'javassist.CtField'
           java_import 'javassist.CtMethod'           
           java_import 'javassist.Modifier'
           java_import 'javax.persistence.Basic'
                 
           field = CtField.make("private #{type} #{name};",self.ct_class)
           self.ct_class.add_field(field)      
           
           get = CtMethod.make(" public #{type} get#{name.capitalize}(){ return #{name}; }",self.ct_class)
           set = CtMethod.make(" public void set#{name.capitalize}(#{type} #{name}){ this.#{name} = #{name}; }",self.ct_class)          
           self.ct_class.add_method(get)
           self.ct_class.add_method(set)
           
           return field
        end
        
        # @return[Class] java byte code generated class
        def to_class          
          self.ct_class.to_class
        end

    end
    
  end
    

end