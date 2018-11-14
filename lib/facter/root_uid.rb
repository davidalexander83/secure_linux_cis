# root_uid.rb
# This contains all users that have a UID of "0"

Facter.add('root_uid') do
  setcode "cat /etc/passwd | awk -F: '($3 == 0) { print $1 }"
end
