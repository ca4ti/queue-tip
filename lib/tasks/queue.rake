# queue.rake - Copyright 2008 Jayson Vaughn 
# Distributed under the terms of the GNU General Public License.
#
#    This file is part of Queue-Tip.
#
#    Queue-Tip is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Queue-Tip is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Queue-Tip.  If not, see <http://www.gnu.org/licenses/>.
#

require "qt_ami"
require "queue_log"

namespace :queue do
  desc "Reset the queue stats and reload from a log-file"
  task :reset => [:environment] do
    begin
      conn = QtAmi.new
      logger = QueueLog.new
      puts "Logged off all agents" if conn.log_off_all_agents
      sleep 2
      puts "Reset queue stats" if conn.reset_queue
      puts "Loading Queue Log now.......(may take a while)"
      num = logger.process_log_file
      puts "Queue Log loaded #{num} records"
    rescue => e 
      puts "Error: #{e}\n" + e.backtrace.join("\n\t")
      puts e.inspect
      raise
    end
  end
end
