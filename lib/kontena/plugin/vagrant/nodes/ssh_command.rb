module Kontena::Plugin::Vagrant::Nodes
  class SshCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions

    parameter "NAME", "Node name"

    def execute
      require_api_url
      require_current_grid

      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/#{current_grid}/#{name}"
      abort("Cannot find Vagrant node #{name}".colorize(:red)) unless Dir.exist?(vagrant_path)

      Dir.chdir(vagrant_path) do
        system('vagrant ssh')
      end
    end
  end
end