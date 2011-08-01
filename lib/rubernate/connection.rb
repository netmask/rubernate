module Rubernate


  class Connection


    attr_accessor :connecion, :factory, :configuration


    def initialize(*classes)

      import org.hibernate.Session
      import org.hibernate.SessionFactory
      import org.hibernate.Transaction
      import org.hibernate.cfg.AnnotationConfiguration


      self.configuration = AnnotationConfiguration.new
      #self.configuration.add_package "rubernate.models"
      classes.each do |clazz|
        clazz.each do |c1|
          configuration.addAnnotatedClass c1
        end
      end
      configuration.set_property "hibernate.dialect", "org.hibernate.dialect.MySQLDialect"
      configuration.set_property "hibernate.connection.url", "jdbc:mysql://localhost:3306/rubernate"
      configuration.set_property "hibernate.connection.driver_class", "com.mysql.jdbc.Driver"
      configuration.set_property "hibernate.current_session_context_class", "thread"
      configuration.set_property "hibernate.connection.username", "root"
      configuration.set_property "hibernate.connection.password", ""


    end


    def get_session
      factory.open_session
    end

    def connect
      self.factory= configuration.buildSessionFactory
      factory.open_session
    end
  end
end