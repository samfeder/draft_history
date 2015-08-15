class Team
    attr_reader :owner, :picks

    def initialize(details, picks)
        @details = set_team_details(details)
        @owner = @details[:owner]
        @picks = picks
    end

    def set_team_details(team_info_elements)
        #ugly array of team name + owner name
        team_details = {}

        owner_arr = team_info_elements.elements.children[1].attr('title').split("(")
        team_details[:team_name] = owner_arr[0].strip()
        team_details[:owner] = owner_arr[1][0...-1]

        team_details
    end

    def total_spent(*positions)
        if positions.length < 1
            @picks.map{|pick| pick[:price]}.reduce(:+)
        else
            @picks.select{ |i| positions.map(&:upcase).include?(i[:pos])}
                .map{|pick| pick[:price]}.reduce(:+)
        end
    end

    def prices_paid(*positions)
        if positions.length < 1
            @picks.map{|pick| pick[:price]}
        else
            @picks.select{ |i| positions.map(&:upcase).include?(i[:pos])}
                .map { |pick| pick[:price]}.sort.reverse
        end
    end

    private :set_team_details
end
