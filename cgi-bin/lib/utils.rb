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

require 'erb'

def render(template, binding = {})
  path = File.join(__dir__, "../../templates/#{template}.erb")
  erb = ERB.new(File.read(path))
  erb.location = path
  erb.result_with_hash(binding)
end

def uri(base = '', **kwargs)
  URI(base).tap do |uri|
    uri.query = URI.encode_www_form kwargs
  end
end

def number_formatter(number)
  number.to_s.gsub(/\B(?=(...)*\b)/, ',')
end

def pluralize(number, singular, plural)
  counter = if number.to_i == 1
              singular
            else
              plural
            end

  "#{number_formatter number.to_i} #{counter}"
end

def filesize(size)
  size = size.to_i

  units = %w[B KiB MiB GiB TiB Pib EiB ZiB]

  return '0.0 B' if size == 0

  exp = (Math.log(size) / Math.log(1024)).to_i
  exp += 1 if size.to_f / 1024**exp >= 1024 - 0.05
  exp = units.size - 1 if exp > units.size - 1

  format('%.0f %s', size.to_f / 1024**exp, units[exp])
end
