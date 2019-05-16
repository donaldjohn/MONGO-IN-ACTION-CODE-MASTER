require 'rubygems'                                                     
require 'mongo'                                                        
                                                                       
VIEW_PRODUCT = 0     # action type constants                                                  
ADD_TO_CART  = 1                                                       
CHECKOUT     = 2                                                       
PURCHASE     = 3                                                       

DATABASE_HOST   = 'localhost'
DATABASE_PORT   = 27017
DATABASE_NAME   = "garden"

client = Mongo::Client.new([DATABASE_HOST], :database => DATABASE_NAME)
client[:user_actions].drop                                        
actions = client[:user_actions, :capped => true, :size => 16384]
actions.create
                                                                        
500.times do |n|             # loop 500 times, using n as the iterator                                          
  doc = {                                                              
    :username => "kbanker",                                            
    :action_code => rand(4), # random value between 0 and 3, inclusive                                         
    :time => Time.now.utc,                                             
    :n => n                                                            
  }                                                                    
  actions.insert_one(doc)                                                  
end                        
