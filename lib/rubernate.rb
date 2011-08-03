$LOAD_PATH.unshift(File.dirname(__FILE__)) 
$LOAD_PATH << "#{File.dirname(__FILE__)}/../lib/native/lib/"

#load all the jars !!

Dir.glob("#{File.dirname(__FILE__)}/../lib/native/lib/*.jar").each do |jar|
  require jar
end

require 'rubernate/init'