require 'spec_helper'

bool_options = [true, false]

describe 'secure_linux_cis::redhat7::cis_5_4_1_2' do
  on_supported_os.each do |os, os_facts|
    bool_options.each do |option|
      context "on #{os}" do
        let(:facts) { os_facts }
        let(:params) { { 'enforced' => option, 'pass_min_days' => 10 } }

        it { is_expected.to compile }

        if option
          it {
            is_expected.to contain_file_line('password change policy')
              .with(
                ensure: 'present',
                path: '/etc/login.defs',
                line: 'PASS_MIN_DAYS 10',
                match: '^#?PASS_MIN_DAYS',
              )
          }
        else
          it {
            is_expected.not_to contain_file_line('password change policy')
          }
        end
      end
    end
  end
end
