require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = "http://learn-co-curriculum.github.io/site-for-scraping/courses"
    doc = Nokogiri::HTML(open(html))
  end

  def get_courses
    doc = get_page
    courses = doc.css('.post')
  end

  def make_courses
    courses = get_courses
    courses.each do |post|
      course = Course.new
      course.title = post.css('h2').text
      course.schedule = post.css('date').text
      course.description = post.css('p').text
    end
    binding.pry
  end
end
