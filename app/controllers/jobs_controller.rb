class JobsController < ApplicationController
	require 'syck'
	def testjob
		# Car.delay.testjob
		# render :text => "success"
		render :text => FrAutoscout24Be.execute
	end

end
