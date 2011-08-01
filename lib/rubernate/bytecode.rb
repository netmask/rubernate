module Rubernate
  class Bytecode

    require 'java'
        
    attr_accessor :class_pool
    
    # :3
    DEFAULT_NAMESPACE = "rubernate.models"
    
    def initialize
      java_import 'javassist.CtClass'
      
      @@mapped_types = Hash[:integer => "Integer" ,
                        :long => "Long",
                        :short => "Short",
                        :float => "Float",
                        :double => "Double",
                        :string => "String" ,
                        :char => "char",
                        :boolean=> "Boolean"]
    end
    
    class << self       
      def mapped_types
        @@mapped_types
      end
    end
   
    def create_class(name)
      java_import 'javassist.ClassPool'
      java_import 'javassist.CtClass'
      java_import 'javax.persistence.Entity'
      
                        
      self.class_pool = ClassPool.get_default
      ProxyClass.new(self.class_pool.makeClass("#{DEFAULT_NAMESPACE}.#{name}"))
    end
    
    class ProxyClass

        attr_accessor :clazz, :ct_class, :frozen, :class_file, :const_pool

        def initialize(ct_class)
          self.ct_class = ct_class
          self.frozen = false
                    
          java_import 'javassist.bytecode.ClassFile'
          java_import 'javassist.bytecode.AnnotationsAttribute'
          java_import 'javassist.bytecode.annotation.Annotation'
          java_import 'javassist.bytecode.annotation.StringMemberValue'
          
          self.class_file = self.ct_class.getClassFile
          self.const_pool = self.class_file.getConstPool
          
          ann_attr = AnnotationsAttribute.new(self.const_pool, AnnotationsAttribute.visibleTag)
          ann = Annotation.new("javax.persistence.Entity",self.const_pool)
          ann.add_member_value "name", StringMemberValue.new(self.ct_class.name,self.const_pool)
          
          
          ann_attr.set_annotation ann          
          self.class_file.addAttribute(ann_attr)                    
        end
        
        
        def add_simple(type,name)
          add_parameter(Rubernate::Bytecode.mapped_types[type],name)
        end
        
        #This wild add a parammeter to given class and generates te setter
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
        end
        
        def to_class          
          self.ct_class.to_class
        end

    end
    
  end
    

end