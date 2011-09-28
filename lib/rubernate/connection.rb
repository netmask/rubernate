module Rubernate


  class Connection


    attr_accessor :connecion, :factory, :configuration


    def initialize(connection,*classes)

      import org.hibernate.Session
      import org.hibernate.SessionFactory
      import org.hibernate.Transaction
      import org.hibernate.cfg.AnnotationConfiguration
      import org.hibernate.ejb.Ejb3Configuration


      self.configuration = Ejb3Configuration.new
      
      self.configuration.set_property "hibernate.dialect",connection[:dialect]
      self.configuration.set_property "hibernate.connection.url", connection[:url]
      self.configuration.set_property "hibernate.connection.driver_class", connection[:driver]
      self.configuration.set_property "hibernate.connection.user", connection[:username]
      self.configuration.set_property "hibernate.connection.password", connection[:password]
      self.configuration.set_property "javax.persistence.provider ","org.hibernate.ejb.HibernatePersistence"
      self.configuration.set_property "hibernate.hbm2ddl.auto", connection[:auto_ddl]
      self.configuration.set_property "hibernate.connection.provider_class","org.hibernate.connection.DriverManagerConnectionProvider"
      classes.each do |clazz|
        clazz.each do |c1|
          configuration.addAnnotatedClass c1
        end
      end

    end


    def entity_manager_factory
      @@factory = configuration.buildEntityManagerFactory
    end
    
    def self.entity_manager
      @@factory.createEntityManager
    end
  end
end