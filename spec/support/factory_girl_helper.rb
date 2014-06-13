module FactoryGirlHelper
  def self.nested_attributes_for(factory_sym)
    attrs = FactoryGirl.attributes_for(factory_sym)
    factory = FactoryGirl.factories[factory_sym]
    factory.associations.names.each do |sym|
      attrs["#{sym}_attributes"] = FactoryGirl.attributes_for sym
    end
    return attrs
  end
end
