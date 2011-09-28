require 'java'

java_import org.objectweb.asm.ClassWriter;
java_import org.objectweb.asm.MethodVisitor;
java_import org.objectweb.asm.Opcodes;
java_import org.objectweb.asm.Type;
java_import org.objectweb.asm.commons.GeneratorAdapter;
java_import org.objectweb.asm.ClassReader;
java_import javax.persistence.Entity;
java_import org.objectweb.asm.util.CheckMethodAdapter;
java_import 'javassist.bytecode.ClassFile'
java_import 'javassist.ClassPool'
java_import 'javassist.ByteArrayClassPath'

module  Rubernate
  class AsmProxyClass < java.lang.ClassLoader
    
    attr_accessor :class_writer, :name
    
    DEFAULT_NAMESPACE = "rubernate/models"
    
    
    @@descriptors = {
      :hash_map => 'Ljava/util/HashMap;',
      :list => 'Ljava/util/List;'
    }
    
    @@annotations = {
      :basic => "Ljavax/persistence/Basic;",
      :id => "Ljavax/persistence/Id;",
      :column => "Ljavax/persistence/Column",
      :one_to_one => "Ljavax/persistence/OneToOne;",
      :one_to_many => "Ljavax/persistence/OneToMany;",
      :many_to_one => "Ljavax/persistence/ManyToOne;",
      :many_to_many => "Ljavax/persistence/ManyToMany;",
      :table => "Ljavax/persistence/Table;",            
    }
     
    attr_accessor :fields_v,:mv
    
    def initialize(name)
      super()
      self.fields_v = {}
      self.name = name
      self.class_writer = ClassWriter.new(0)
      self.class_writer.visit(Opcodes.V1_6 ,Opcodes.ACC_PUBLIC + Opcodes.ACC_SUPER, name , nil, "java/lang/Object", nil)    
      eav = self.class_writer.visitAnnotation("Ljavax/persistence/Entity;", true)
      eav.visitEnd            
      self.mv = self.class_writer.visitMethod(Opcodes.ACC_PUBLIC,"<init>","()V",nil,nil)
      self.mv.visitCode
      self.mv.visitVarInsn(Opcodes.ALOAD, 0)
      self.mv.visitMethodInsn(Opcodes.INVOKESPECIAL, "java/lang/Object", "<init>", "()V")
      self.mv.visitInsn(Opcodes.RETURN)
      self.mv.visitMaxs(1, 1);
      self.mv.visitEnd();
    end
    
    #A field is a class field and gettter setter method
    def add_field(name, descriptor, signature = nil)            
      fv = self.class_writer.visitField(Opcodes.ACC_PRIVATE , name, descriptor, signature, nil)
      add_getter(name,descriptor,signature)
      add_setter(name,descriptor,signature)
      self.fields_v[name] = fv
      fv #yuuuck!      
    end
    
    def add_getter(name,descriptor,signature = nil)
     self.mv = self.class_writer.visitMethod(Opcodes.ACC_PUBLIC, "get#{name.capitalize}", "()#{descriptor}", signature, nil)
     self.mv.visitCode()
     self.mv.visitVarInsn(Opcodes.ALOAD, 0)
     self.mv.visitFieldInsn(Opcodes.GETFIELD, self.name, name, descriptor)
     self.mv.visitInsn(Opcodes.ARETURN)
     self.mv.visitMaxs(1, 1);
     self.mv.visitEnd();        
    end
    
    def add_setter(name,descriptor,signature = nil)
     self.mv = self.class_writer.visitMethod(Opcodes.ACC_PUBLIC, "set#{name.capitalize}", "(#{descriptor})V", signature, nil)
     self.mv.visitCode()
     self.mv.visitVarInsn(Opcodes.ALOAD, 0)
     self.mv.visitVarInsn(Opcodes.ALOAD, 1)
     self.mv.visitFieldInsn(Opcodes.PUTFIELD, self.name , name , descriptor)
     self.mv.visitInsn(Opcodes.RETURN)
     self.mv.visitMaxs(2, 2)
     self.mv.visitEnd()      
    end
    
    
    
    def add_simple(type,name)
      fv = add_field name, "Ljava/lang/#{Rubernate::Bytecode.mapped_types[type]};"
      av = fv.visitAnnotation"Ljavax/persistence/Basic;",true
      av.visitEnd
      fv
    end
    
    def add_annotation(fw,name)
      av = fw.visitAnnotation("L#{name};",true)
      av.visitEnd
    end
    
    def signature(descriptor,t,k = nil)
      "#{descriptors[descriptor]}<L#{t};#{ k != nil ? "L#{k};":""}>;"
    end
    
    def descriptors
      @@descriptors
    end
  
    
    def to_class
      self.fields_v.each do |k,v|
        v.visitEnd
      end
      self.class_writer.visitEnd
      class_bytes = self.class_writer.toByteArray
      
      
      cp = ClassPool.getDefault();
      cp.insertClassPath(ByteArrayClassPath.new(self.name, class_bytes));

      cp.get(self.name).to_class
    end
    
  end
end



