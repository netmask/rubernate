require 'java'
module Rubernate
  class Entity 
    include Relations
    
    attr_accessor :proxy_class
    
    def self.find(id)
      Connection.entity_manager.create_query("SELECT e FROM #{self} as e where e.id = :id").set_parameter(id).get_single_result
    end
    
    def self.all()
      Connection.entity_manager.create_query("SELECT e FROM #{self} as e ").result_list
    end
    
    def self.by_hql(hql)
      Connection.entity_manager.create_query(hql)
    end
    
    def save
      em = Connection.entity_manager 
      em.transaction.begin
      em.persist(self)
      em.transaction.commit
    end
  end
end
