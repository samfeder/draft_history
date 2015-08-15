require 'nokogiri'
require 'open-uri'
require_relative "./team.rb"

load "./team.rb"

LEAGUE_IDS = {
    cuse: 199254,
    newCity:  233285
}
SEASON = 2014

class Draftboard
    attr_reader :teams

    def initialize(league_id, season)
        @teams = []
        @doc = Nokogiri::HTML(open("http://games.espn.go.com/ffl/tools/draftrecap?leagueId=#{league_id}&seasonId=#{season}"))
        fillTeams
    end

    def fillTeams
        @doc.css('table').each_with_index do |teams, i|
            next if i < 2
            selections = []
            details = []

            teams.css("tr").each_with_index do | data_row, i |
                if i == 0
                    details = data_row
                else
                    selections << playerPick(data_row)
                end
            end
            team = Team.new(details, selections)
            @teams << team
        end
    end


    def playerPick(selection)
        pick = {}
        pick[:place] = selection.children[0].text
        pick[:player] = selection.children[1].text.split(',')[0]
        pick[:price] = selection.children[2].text.gsub(/\D/, '').to_i

        details = selection.children[1].text.split(',').map(&:strip)
        if !details[1].nil?
            pick[:team] = details[1].split(/[[:space:]]/)[0]
            pick[:pos] = details[1].split(/[[:space:]]/)[1]
        else
            pick[:pos] = selection.children[1].text.split(',')[0].split(/[[:space:]]/)[1]
        end
        pick
    end

    private :playerPick, :setTeamDetails, :fillTeams
end

@draftboard = Draftboard.new(LEAGUE_IDS[:newCity], SEASON)
