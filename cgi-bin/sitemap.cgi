#!/usr/bin/env ruby

# Wayback Machine Site Map CGI Script
# -----------------------------------
# Uses the Wayback Machine's CDX API to retrieve a
# list of captured URLs under the given wildcard URL.
#
# Wayback Classic
# Copyright (C) 2024 Jessica Stokes
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require 'cgi'

require_relative 'lib/cdx'
require_relative 'lib/encoding'
require_relative 'lib/error_reporting'
require_relative 'lib/permit_world_writable_temp' if ENV["FORCE_WORLD_WRITABLE_TEMP"] == "true"
require_relative 'lib/utils'
require_relative 'lib/web_client'

module WaybackClassic
  module Sitemap
    PAGE_SIZE = 50

    def self.run
      legacy_encoding = LegacyClientEncoding.detect

      CGI.new.tap do |cgi|
        ErrorReporting.catch_and_respond(cgi) do
          if cgi.params.keys - ["q", "page", "filter"] != [] || cgi.params["q"]&.first.nil? || cgi.params["q"]&.first&.empty?
            raise ErrorReporting::BadRequestError.new("A `q` parameter must be supplied, and `page` and `filter` parameters are optional")
          end

          query = cgi.params["q"]&.first
          page = cgi.params["page"]&.first&.to_i || 1
          filter = cgi.params["filter"]&.first

          response = begin
                       WebClient.open uri("https://web.archive.org/cdx/search/cdx",
                                          url: query,
                                          output: "json",
                                          collapse: "urlkey",
                                          fl: "original,mimetype,timestamp,endtimestamp,groupcount,uniqcount",
                                          filter: "!statuscode:[45]..")
                     rescue OpenURI::HTTPError
                       raise ErrorReporting::ServerError.new("Couldn't retrieve captured URLs for this wildcard URL")
                     end

          cdx_results = CDX.objectify response.read

          # Hold onto the count of results for the entire thing
          total_count = cdx_results.length

          # Apply MIME Type and URL filters
          if filter
            cdx_results = cdx_results.select do |cdx_result|
              cdx_result["mimetype"].downcase.include?(filter.downcase) || cdx_result["original"].downcase.include?(filter.downcase)
            end
          end

          # Grab the count of matching results, and calculate the page information
          scoped_count = cdx_results.length
          page_count = (scoped_count.to_f / PAGE_SIZE).ceil
          page_count = 1 if page_count == 0

          # Grab this page of results, and go!
          cdx_results = cdx_results.slice((page - 1) * PAGE_SIZE, PAGE_SIZE)

          cgi.out "type" => "text/html",
                  "charset" => "UTF-8",
                  "status" => "OK" do
            render "sitemap.html",
                   query: query,
                   filter: filter,
                   total_count: total_count,
                   scoped_count: scoped_count,
                   page: page || 1,
                   page_count: page_count,
                   cdx_results: cdx_results,
                   legacy_encoding: legacy_encoding
          end
        end
      end
    end
  end
end

WaybackClassic::Sitemap.run if $PROGRAM_NAME == __FILE__
