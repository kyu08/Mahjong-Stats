class RoundController < ApplicationController
    before_action :authenticate_user,{only: [:input,:create]}
    def input
    end

    def create
        params[:point_number] == nil ? @point = 0 : @point = params[:point_number].to_i
        if params[:point] == "0"
            @point = 0
        elsif params[:point] == "2"
            @point = -@point
        end

        case params[:doing]
        when    "0"
            @meld = 0
            @riichi = 0
        when    "1"
            @meld = 1
            @riichi = 0
        when    "2"
            @meld = 0
            @riichi = 1
        end

        @rank = params[:rank]
        @round = Round.new(user_id: @current_user.id,point: @point,meld: @meld,riichi: @riichi,rank: @rank)
        @round.save
        redirect_to("/date/input")
        flash[:notice] = "局データを登録しました！"
    end

    def analysis
        @round = Round.where(user_id: @current_user.id)
        @winning_times = @round.where("point > 0").count
        @ducking_times = @round.where("point < 0").count
        @total_rounds = @round.count
        @total_winning_point = @round.where("point > 0").sum("point")
        @total_ducking_point = @round.where("point < 0").sum("point").abs
        @melding_times = @round.where("meld = 1").count
        @riichi_times = @round.where("riichi = 1").count
        
        @meld_and_win_times = @round.where("meld = 1 and point > 0").count
        @riichi_and_win_times = @round.where("riichi = 1 and point > 0").count
        @meld_and_duck_times = @round.where("meld = 1 and point < 0").count
        @riichi_and_duck_times = @round.where("riichi = 1 and point < 0").count
        
        binding.pry

        @ranks = @round.where("rank >= 1")
        @total_hanchan = @ranks.count
        @sum_rank = @ranks.sum("rank")
        @total_1_times = @ranks.where("rank = 1").count
        @total_2_times = @ranks.where("rank = 2").count
        @total_3_times = @ranks.where("rank = 3").count
        @total_4_times = @ranks.where("rank = 4").count
        @total_rounds  ==  0 ? @winning_per  =  0 : @winning_per = (@winning_times.to_f / @total_rounds*100).round(1)
        @total_rounds  ==  0 ? @ducking_per  =  0 : @ducking_per = (@ducking_times.to_f / @total_rounds*100).round(1)
        @winning_times  ==  0 ? @winning_points_av  =  0 : @winning_points_av = (@total_winning_point.to_f / @winning_times).round(0)  
        @ducking_times  ==  0 ? @ducking_points_av  =  0 : @ducking_points_av = (@total_ducking_point.to_f / @ducking_times).round(0)
        @total_rounds  ==  0 ? @riichi_per  =  0 : @riichi_per = (@riichi_times.to_f / @total_rounds*100).round(1)
        @total_rounds  ==  0 ? @meld_per  =  0 :  @meld_per = (@melding_times.to_f / @total_rounds*100).round(1)
        @riichi_times  ==  0 ? @riichi_and_win__per  =  0 : @riichi_and_win__per = (@riichi_and_win_times.to_f / @riichi_times*100).round(1)
        @riichi_times  ==  0 ? @riichi_and_duck_per  =  0 : @riichi_and_duck_per = (@riichi_and_duck_times.to_f / @riichi_times*100).round(1)
        @melding_times  ==  0 ? @meld_and_win_per  =  0 : @meld_and_win_per = (@meld_and_win_times.to_f / @melding_times*100).round(1)
        @melding_times  ==  0 ? @meld_and_duck_per  =  0 : @meld_and_duck_per = (@meld_and_duck_times.to_f / @melding_times*100).round(1)
        @total_hanchan  ==  0 ? @rank_av  =  0 : @rank_av = (@sum_rank.to_f / @total_hanchan).round(1)
        @total_hanchan  ==  0 ? @rank_1  =  0 : @rank_1 = (@total_1_times.to_f / @total_hanchan*100).round(1)
        @total_hanchan  ==  0 ? @rank_2  =  0 : @rank_2 = (@total_2_times.to_f / @total_hanchan*100).round(1)
        @total_hanchan  ==  0 ? @rank_3  =  0 : @rank_3 = (@total_3_times.to_f / @total_hanchan*100).round(1)
        @total_hanchan  ==  0 ? @rank_4  =  0 : @rank_4 = (@total_4_times.to_f / @total_hanchan*100).round(1)
        @rank_1_2 = (@rank_1 + @rank_2).round(1)
    end
end
