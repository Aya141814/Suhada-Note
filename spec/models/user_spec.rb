require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したバリデーションが機能しているか" do
      user = create(:user)
      expect(user).to be_valid
    end
    it "ニックネームが空の場合は無効であること" do
      user = build(:user, nickname: nil)
      expect(user).to be_invalid
    end
    it "ニックネームが255文字以内であること" do
      user = build(:user, nickname: "a" * 256)
      expect(user).to be_invalid
    end
    it "パスワードが空の場合は無効であること" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end
    it "パスワードが3文字以上であること" do
      user = build(:user, password: "ab")
      expect(user).to be_invalid
    end
    it "パスワードが確認用パスワードと一致していること" do
      user = build(:user, password: "password", password_confirmation: "wrong_password")
      expect(user).to be_invalid
    end
    it "メールアドレスが空の場合は無効であること" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end
    it "メールアドレスが重複している場合は無効であること" do
      user = create(:user)
      duplicate_user = build(:user, email: user.email)
      expect(duplicate_user).to be_invalid
    end
  end

  describe "#own?" do
    it "自分のものである場合はtrueを返すこと" do
      user = create(:user)
      board = create(:board, user: user)
      expect(user.own?(board)).to be true
    end
    
    it "自分のものでない場合はfalseを返すこと" do
      user = create(:user)
      other_user = create(:user)
      board = create(:board, user: other_user)
      
      expect(user.own?(board)).to be false
    end
    
    it "nilが渡された場合はfalseを返すこと" do
      user = create(:user)
      
      expect(user.own?(nil)).to be false
    end
  end
  
  describe "#cheer関連メソッド" do
    let(:user) { create(:user) }
    let(:board) { create(:board) }
    
    describe "#cheer" do
      it "投稿をcheerできること" do
        expect { user.cheer(board) }.to change { user.cheers.count }.by(1)
      end
    end
    
    describe "#uncheer" do
      it "投稿のcheerを解除できること" do
        user.cheer(board)
        expect { user.uncheer(board) }.to change { user.cheers.count }.by(-1)
      end
    end
    
    describe "#cheer?" do
      it "応援している場合はtrueを返すこと" do
        user.cheer(board)
        expect(user.cheer?(board)).to be true
      end
      
      it "応援していない場合はfalseを返すこと" do
        expect(user.cheer?(board)).to be false
      end
    end
  end
  
  describe "ストリーク関連メソッド" do
    let(:user) { create(:user) }
    
    describe "#default_streak" do
      context "ストリークが存在する場合" do
        let!(:streak) { create(:streak, user: user) }
        
        it "既存のストリークを返すこと" do
          expect(user.default_streak).to eq streak
        end
      end
      
      context "ストリークが存在しない場合" do
        it "新しいストリークを作成して返すこと" do
          expect { user.default_streak }.to change { Streak.count }.by(1)
        end
      end
    end
    
    describe "#current_streak" do
      context "アクティブなストリークがある場合" do
        before do
          streak = create(:streak, user: user, current_streak: 5)
          allow(streak).to receive(:active?).and_return(true)
          allow(streak).to receive(:display_streak).and_return(5)
          allow(streak).to receive(:days_since_last_post).and_return(0)
        end
        
        it "適切な値を含むハッシュを返すこと" do
          result = user.current_streak
          expect(result[:count]).to eq 5
          expect(result[:active]).to be true
          expect(result[:days_since_last]).to eq 0
        end
      end
      
      context "アクティブなストリークがない場合" do
        before do
          streak = create(:streak, user: user, current_streak: 5)
          allow(streak).to receive(:active?).and_return(false)
          allow(streak).to receive(:days_since_last_post).and_return(1)
        end
        
        it "適切な値を含むハッシュを返すこと" do
          result = user.current_streak
          expect(result[:count]).to eq 0
          expect(result[:active]).to be false
          expect(result[:days_since_last]).to eq 1
        end
      end
    end
  end
  
  describe "トロフィー関連メソッド" do
    let(:user) { create(:user) }
    let(:trophy) { create(:trophy) }
    
    describe "#has_trophy?" do
      it "トロフィーを持っている場合はtrueを返すこと" do
        create(:user_trophy, user: user, trophy: trophy)
        expect(user.has_trophy?(trophy)).to be true
      end
      
      it "トロフィーを持っていない場合はfalseを返すこと" do
        expect(user.has_trophy?(trophy)).to be false
      end
    end
    
    describe "#check_and_award_trophies" do
      let!(:streak_trophy) { create(:trophy, trophy_type: "streak", requirement: 5) }
      
      context "トロフィーの条件を満たしている場合" do
        it "トロフィーを授与すること" do
          allow_any_instance_of(Trophy).to receive(:check_achievement).and_return(true)
          
          expect { user.check_and_award_trophies }.to change { user.trophies.count }.by(1)
        end
        
        it "授与したトロフィーのリストを返すこと" do
          allow_any_instance_of(Trophy).to receive(:check_achievement).and_return(true)
          
          result = user.check_and_award_trophies
          expect(result).to include(streak_trophy)
        end
      end
      
      context "トロフィーの条件を満たしていない場合" do
        it "トロフィーを授与しないこと" do
          allow_any_instance_of(Trophy).to receive(:check_achievement).and_return(false)
          
          expect { user.check_and_award_trophies }.not_to change { user.trophies.count }
        end
        
        it "空の配列を返すこと" do
          allow_any_instance_of(Trophy).to receive(:check_achievement).and_return(false)
          
          result = user.check_and_award_trophies
          expect(result).to be_empty
        end
      end
      
      context "すでにトロフィーを持っている場合" do
        before do
          create(:user_trophy, user: user, trophy: streak_trophy)
        end
        
        it "同じトロフィーを再度授与しないこと" do
          expect { user.check_and_award_trophies }.not_to change { user.trophies.count }
        end
      end
    end
  end
end