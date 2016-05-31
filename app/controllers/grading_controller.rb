class GradingController < ApplicationController
    
  def static(params)
    puts case params[:type]
    when "static"
      static(params)
    when "inter"
      interA(params)
    when "genstat"
      interB(params)
    when "sinter"
      sinter(params)
    else
      puts "somethings wrong"
    end
  end
#
  def inter
    
  end
#
  def genstat
    
  end
#
  def sinter
    
  end
########

  
end
