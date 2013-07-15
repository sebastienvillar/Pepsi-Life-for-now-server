 # -*- coding: utf-8 -*-
require 'sinatra'
require 'sinatra/activerecord'
require './helpers/constants'

post %r{^/images/?$} do
	haltJsonp 400, "Content must be in png format" unless request.content_type == "image/png"
	identifier = Time.now.to_f.to_s
	identifier.gsub!(".", "")
	File.open(Constants::IMAGES_PATH + identifier, "w") do |f|
		f.write request.body.read
	end

	result = {
		"url" => "images/" + identifier
	}
	jsonp({:status => 200, :body => result})
end

get %r{^/images/(\d+)/?$} do
	identifier = params[:captures][0]
	path = Constants::IMAGES_PATH + identifier
	haltJsonp 404 unless File.exist?(path)

	file = File.open(path, "rb")
	content = file.read
	file.close

	content_type :png
	body content
	status 200
end