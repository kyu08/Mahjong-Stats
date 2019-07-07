class RoundController < ApplicationController
    before_action :authenticate_user,{only: [:input,:create]}
    def input

    end
    def create
        point=params[:point_number]  #params[:point-number]=φを受け取った時ってエラーになる？
        if params[:point]==0
            point=0
        elsif params[:point]==2
            point=point*-1
        end
        if params[:action]==0
            meld=0
            riichi=0
        elsif params[:action]==1
            meld=1
            riichi=0
        else
            meld=0
            riichi=1
        end
        rank=params[:rank]
        @round=Round.new(user_id: @current_user.id,point: point,meld: meld,riichi: riichi,rank: rank)
        @round.save
        redirect_to("/date/input")
    end

    def analysis
        @round=Round.find_by(user_id: @current_user.id)
        winning_times=@round.class.where("point>?",1).count
        ducking_times=@round.class.where("point<?",-1).count
        total_rounds=@round.class.count
        total_winning_point=@round.class.where("point>?",1).sum("point")
        total_ducking_point=@round.class.where("point<?",-1).sum("point")
        melding_times=@round.class.where("meld=1").count
        riichi_times=@round.class.where("riichi=1").count
        meld_and_win_times=@round.class.where("meld=1 and point>1").count
        riichi_and_win_times=@round.class.where("riichi=1 and point>1").count
        meld_and_duck_times=@round.class.where("meld=1 and point<-1").count
        riichi_and_duck_times=@round.class.where("riichi=1 and point<-1").count
        ranks=@round.class.where("rank>1")
        total_hanchan=ranks.count
        sum_rank=ranks.sum("rank")
        total_1_times=ranks.where("rank=1").count
        total_2_times=ranks.where("rank=2").count
        total_3_times=ranks.where("rank=3").count
        total_4_times=ranks.where("rank=4").count

        @winning_per=winning_times/total_rounds*100
        @ducking_per=ducking_times/total_rounds*100
        @winning_points_av=total_winning_point/winning_times rescue 0
        @ducking_points_av=total_ducking_point/ducking_times rescue 0
        @riichi_per=riichi_times/total_rounds*100
        @meld_per=melding_times/total_rounds*100
        @riichi_and_win__per=riichi_and_win_times/riichi_times*100 rescue 0
        @riichi_and_duck_per=riichi_and_duck_times/riichi_times*100 rescue 0
        @meld_and_win_per=meld_and_win_times/melding_times*100 rescue 0
        @meld_and_duck_per=meld_and_duck_times/melding_times*100 rescue 0
        @rank_av=sum_rank/total_hanchan rescue 0
        @rank_1=total_1_times/total_hanchan*100 rescue 0
        @rank_2=total_2_times/total_hanchan*100 rescue 0
        @rank_3=total_3_times/total_hanchan*100 rescue 0
        @rank_4=total_4_times/total_hanchan*100 rescue 0
        @rank_1_2=@rank_1+@rank_2

    end

end
