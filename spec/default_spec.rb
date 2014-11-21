require 'spec_helper'


describe 'rabbitmq::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates a directory for mnesiadir' do
    expect(chef_run).to create_directory(node['rabbitmq']['mnesiadir'])
  end

   it 'creates a template with attributes' do
    expect(chef_run).to create_template("#{node['rabbitmq']['config_root']}/rabbitmq-env.conf").with(
      user:   'root',
      group:  'root',
      backup: false,
      source: 'rabbit-env.conf.erb',
      mode: 00644

                        ).to notify("service[#{node['rabbitmq']['service_name']}]").to(:restart).immediately

   end
end
