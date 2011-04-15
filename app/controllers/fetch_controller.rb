# coding: utf-8
class FetchController < ApplicationController
	require 'open-uri'
  def create_cate
	Car.create_cate
  end
	def getAutoVlanDe
		AutoVlanDe.delay.execute
		render :text => "success"
	end
	




end
