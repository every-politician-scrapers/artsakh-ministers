#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def holder_entries
    # not sure why this doesn't work: noko.xpath("//ul[1]//li[a]")
    noko.xpath('//ul').first.css('li')
  end

  class Officeholder < OfficeholderBase
    def combo_date?
      true
    end

    def raw_combo_date
      noko.text.split(':').first
    end

    def name_cell
      noko
    end

    def empty?
      false
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
