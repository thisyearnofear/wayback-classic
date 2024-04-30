# Copyright (C) 1993-2013 Yukihiro Matsumoto. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

require 'tmpdir'

# Monkey patch permitting use of a world-writable temp directory
# --------------------------------------------------------------
# This is generally going to be a bad idea, as in most situations it reduces
# security. In my case, my web host uses a complicated chroot-style setup which
# they alledge relieves these security issues, and there's no user-serviceable
# way to change the permissions. Do not enable this patch unless you are
# absolutely certain this is reasonable for you.
# Based on Ruby 2.7 code at https://github.com/ruby/ruby/blob/67f1cd20bfb97ff6e5a15d27c8ef06cdb97ed37a/lib/tmpdir.rb#L18-L34

class Dir
  ##
  # Returns the operating system's temporary file path.

  def self.tmpdir
    tmp = nil
    [ENV['TMPDIR'], ENV['TMP'], ENV['TEMP'], @@systmpdir, '/tmp', '.'].each do |dir|
      next unless dir

      dir = File.expand_path(dir)
      begin
        if (stat = File.stat(dir)) && stat.directory? && stat.writable?
          tmp = dir
          break
        end
      rescue StandardError
        nil
      end
    end
    raise ArgumentError, 'could not find a temporary directory' unless tmp

    tmp
  end
end
