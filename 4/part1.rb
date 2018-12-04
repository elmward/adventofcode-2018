require 'time'
TIMESTAMP_REGEX = /\A\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\]/

def sort(entries)
  entries.sort_by do |entry|
    Time.parse(entry.match(TIMESTAMP_REGEX)[1])
  end
end

def naps(sorted_entries)
  guard_regex = /.*Guard #(\d+).*/
  minute_regex = /:(\d\d)/

  Hash.new { |hash, key| hash[key] = Array.new }.tap do |guard_naps| 
    current_guard = nil
    asleep_time = nil
    sorted_entries.each do |entry|
      timestamp = Time.parse(entry.match(TIMESTAMP_REGEX)[1])
      match = entry.match(guard_regex)
      if match
        current_guard = match[1]
      else
        minute = entry.match(minute_regex)[1]
        if !asleep_time
          asleep_time = timestamp.min
        else
          guard_naps[current_guard] << (asleep_time...timestamp.min)
          asleep_time = nil
        end
      end
    end
  end
end

def laziest_guard(nap_hash)
  sleepy_time = {}

  nap_hash.each do |guard, naps|
    minutes_slept = naps.map(&:sum).sum
    sleepy_time[minutes_slept] = guard
  end

  sleepy_time.max_by { |minutes_slept, guard| minutes_slept }[1]
end

def sleepiest_minute(guard, nap_hash)
  sleepy_times = nap_hash[guard].flat_map(&:to_a).sort.chunk { |n| n }.to_a.sort_by { |chunk| chunk[1].count }.reverse
  [sleepy_times[0][0], sleepy_times[0][1].count]
end

def sleepiest_guard_on_single_minute(nap_hash)
  guard_minutes = []

  nap_hash.each do |guard, _|
    minute_and_times_asleep = sleepiest_minute(guard, nap_hash)
    guard_minutes << [guard.to_i, minute_and_times_asleep[0], minute_and_times_asleep[1]]
  end

  guard_minutes.sort_by { |guard_minute| guard_minute[2] }.last
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  entries = File.open(filename).readlines
  log = sort(entries)
  nap_hash = naps(log)
  guard_id = laziest_guard(nap_hash)
  minute = sleepiest_minute(guard_id, nap_hash)[0]
  guard_minute_times = sleepiest_guard_on_single_minute(nap_hash)

  puts guard_minute_times[0] * guard_minute_times[1]
end

main if __FILE__ == $PROGRAM_NAME
