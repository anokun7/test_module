Facter.add(:rootpassword) do
  setcode 'grep root /etc/shadow | cut -d: -f2 '
end
