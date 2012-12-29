#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/auth/github'

module GovWeb
  class App < Sinatra::Base
    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
    end

    configure do
      set :public_folder, Proc.new { File.join(root, "static") }

      enable :sessions

      set :github_options, {
        :scopes    => "user", # OPTIMIZE: Do we need any other scopes? Maybe not
        :secret    => ENV['GITHUB_CLIENT_SECRET'],
        :client_id => ENV['GITHUB_CLIENT_ID'],
      }

      # Really only to prevent whitespace in generated HTML. Rails built-in.
      set :erb, :trim => '-'
    end

    register Sinatra::Auth::Github

    helpers do

      def username
        session[:identity] ? session[:identity] : 'Unknown user'
      end

      # @note http://developer.github.com/v3/orgs/#list-user-organizations
      def user_orgs
        github_request("user/orgs")
      end

      # @note http://developer.github.com/v3/repos/#list-organization-repositories
      def get_org_repos(org)
        puts github_request("orgs/#{org}/repos")
      end

      # We remove the "Owner" team here, as this adds useless connections
      # @note http://developer.github.com/v3/orgs/teams/#list-teams
      def org_teams(org)
        results = github_request("orgs/#{org}/teams")
        # blacklist = ['owners']
        filtered = results.reject { |h| ['owners'].include? h['slug'] }
      end

      # @note http://developer.github.com/v3/orgs/teams/#list-team-members
      def team_members(team)
        github_request("teams/#{team}/members")
      end

      # Assemble a Hash keyed by team_id whose values are hashes of 
      # {:id => int, :members => Array }
      #
      # @param [Int] team id
      # @return [Hash]
      # @example
      #   { :id => 1234, :members => ['mike', 'dan'] }
      # @note http://developer.github.com/v3/orgs/teams/#list-team-members
      def get_team_members(team_id)
        members = Array.new
        github_request("teams/#{team_id}/members").each do |member|
          members << member['login']
        end

        team_members = { :id => team_id, :members => members }
      end

      # Get the team_id, permission and repos
      #
      # @param [Int] team id
      # @return [Hash]
      # @example
      #   { :id => 1234, :repos => ['fooproj', 'barproj'] }
      # @note http://developer.github.com/v3/orgs/teams/#list-team-repos
      def get_team_repos(team_id)
        repos = Array.new
        github_request("teams/#{team_id}/repos").each do |repo|
          repos << repo['name']
        end

        team_repos = { :id => team_id, :repos => repos }
      end

      def is_org_owner(org)
        # TODO: tell user if they are an owner of an org
      end

    end

    # Show us the homepage
    get '/' do
      erb :index
    end

    # I guess you wanted to leave, eh?
    get '/logout' do
      session.delete(:identity)
      logout!
      erb :logout
    end

    # This method ensures that all pages that require Github access 
    before '/secure/*' do
      if !session[:identity] then
        session[:previous_url] = request['REQUEST_PATH']
        authenticate!
        session[:identity] = github_user.login
        # TODO: If the user cancles the authentication, what happens?
        # @error = 'Sorry mister, you need to be logged in to do that'
        # halt
      end
    end

    # This is the landing page, where we display all the orgs a user is
    # associated with. There are links to graph any org.
    get '/secure/orgs' do
      erb :orgs
    end

    # The deliciousness of visualization is here. See graph.erb for the rendering.
    get '/secure/graph/:id' do
      # we can do some fun calculations here before we start graphing
      #
      # things we need to collect:
      # Org: Team Names (done in graph.erb)
      # Teams: Member names (done below)
      # Teams: Repo names (done below)
      # Team-to-Member edges (done in graph.erb)
      # Team-to-Repo edges (done in graph.erb)

      # permissions a team has

      @uniq_members = Array.new
      @uniq_repos = Array.new

      org_teams(params[:id]).each do |team|

        get_team_members(team['id'])[:members].each do |member|
          @uniq_members << member
        end

        get_team_repos(team['id'])[:repos].each do |repo|
          @uniq_repos << repo
        end

      end

      @uniq_members.uniq!
      @uniq_repos.uniq!

      erb :graph
    end

  end
end
