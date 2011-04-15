# coding: utf-8
class FetchController < ApplicationController
	require 'open-uri'
	  def create_cate
		Car.create_cate
	  end
	def getAutoVlanDe
		AutoVlanDe.delay.execute
		flash[:success] ="Fetching AutoVlanDe data is under way !"
		redirect_to :action =>:results
	end
	def getFrAutoscout24Be
		FrAutoscout24Be.delay.execute
		flash[:success] ="Fetching FrAutoscout24Be data is under way !"
		redirect_to :action =>:results
	end
	
	def results
		# AutoVlanDe.pagi
	end

def index
	
end


end
