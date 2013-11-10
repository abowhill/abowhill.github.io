---
layout: single
title: "When life hands you lemons..."
tags: Ruby
---

If you're unemployed and want to know how many days it's been, how many years experience you have, and with which companies, this Ruby class will tell you. Basically, initialize the WorkHistoryAnalysis class, pass in each experience as "<name>, [start date], [end date]" in YYYY,MM,DD format as shown at the bottom of the file. A little report will be generated at the console.

~~~ ruby
require 'date';
 
class WorkHistoryAnalysis
   attr_accessor :total, :company, :latest
 
   def initialize()
      @total_days = 0
      @company = Hash.new
      @latest = Date.new
   end
 
   def workedFor(who, from, to)
      to_d = Date.new(to[0],to[1],to[2])
      from_d = Date.new(from[0],from[1],from[2])
 
      latest?(to_d)
 
      days = (to_d - from_d).to_i
 
      if (@company.has_key?(who))
         @company[who] += days
      else
         @company[who] = days
      end
 
      @total_days += days
   end
 
   def latest?(dat)
      if ((dat <=> @latest) > 0)
         @latest = dat
      else
         return false
      end
      return true
   end
 
   def employed
      years = days2yrs(@total_days)
      return ["Employed for:"],["   #{years} years [#{@total_days} total days]"]
   end
 
   def unemployed
      days = (Date.today - @latest).to_i
      years = days2yrs(days)
      return ["Currently unemployed for:"],["   #{years} years [#{days} days]"],["Last worked:"],["   #{@latest.to_s}"]
   end
 
   def days2yrs(days)
      years = days/365.to_f
      return (years * 100).round.to_f / 100
   end
 
   def list_experiences
      str = "Employment breakdown by company:\n"
      co = @company.sort_by { |k,v| v }
      co.each { |a| str += "   #{a[0]} #{days2yrs(a[1])} years [#{a[1]} days]\n" }
      return str      
   end
 
   def print
      puts employed
      puts unemployed
      puts list_experiences
   end
end

# Part where you enter your own work history 
 
W = WorkHistoryAnalysis.new
W.workedFor("NWlink",[1996,2,1],[1997,7,1])
W.workedFor("Orrtax",[1997,8,1],[2000,1,1])
W.workedFor("Hostpro",[2000,2,1],[2001,11,1])
W.workedFor("College",[2002,4,1],[2005,12,16])
W.workedFor("Microsoft",[2006,1,1],[2006,5,1])
W.workedFor("Marchex",[2006,6,1],[2008,4,1])
W.workedFor("Microsoft",[2008,10,1],[2009,9,26])
W.workedFor("Microsoft",[2011,9,1],[2012,9,1])
W.print
~~~~~
<p/>

The report will look something like this:

~~~
Employed for:
   13.45 years [4909 total days]
Currently unemployed for:
   1.19 years [435 days]
Last worked:
   2012-09-01
Employment breakdown by company:
   NWlink 1.41 years [516 days]
   Hostpro 1.75 years [639 days]
   Marchex 1.84 years [670 days]
   Microsoft 2.32 years [846 days]
   Orrtax 2.42 years [883 days]
   College 3.71 years [1355 days]
~~~~~~
<p/>
