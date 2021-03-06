# This fact xorg_x11_packages returns an array of installed packages that start with xorg-x11*
#
Facter.add('xorg_x11_packages') do
  confine kernel: :linux
  setcode do
    package_list = Facter::Core::Execution.exec('rpm -qa xorg-x11*')
    package_list.split("\n")
  end
end
