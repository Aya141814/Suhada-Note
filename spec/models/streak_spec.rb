require 'rails_helper'

RSpec.describe Streak, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }

    it 'current_streak、user_idがあれば有効' do
      streak = build(:streak, user: user, current_streak: 1)
      expect(streak).to be_valid
    end

    it 'current_streakがなければ無効' do
      streak = build(:streak, user: user, current_streak: nil)
      expect(streak).not_to be_valid
    end

    it 'current_streakが0未満だと無効' do
      streak = build(:streak, user: user, current_streak: -1)
      expect(streak).not_to be_valid
    end

    it 'userがなければ無効' do
      streak = build(:streak, user: nil)
      expect(streak).not_to be_valid
    end
  end

  describe 'インスタンスメソッド' do
    let(:user) { create(:user) }
    let(:streak) { create(:streak, user: user, current_streak: 1, start_date: Date.yesterday, end_date: Date.yesterday) }

    describe '#record_activity' do
      context '昨日が最終活動日の場合' do
        it '連続記録が増える' do
          expect {
            streak.record_activity
          }.to change { streak.current_streak }.by(1)
        end

        it '最終活動日が更新される' do
          streak.record_activity
          expect(streak.end_date).to eq(Date.today)
        end
      end

      context '既に今日記録済みの場合' do
        before do
          streak.update(end_date: Date.today)
        end

        it '連続記録は変わらない' do
          expect {
            streak.record_activity
          }.not_to change { streak.current_streak }
        end
      end

      context '連続が途切れている場合' do
        before do
          streak.update(end_date: Date.today - 2.days)
        end

        it '連続記録は1になる' do
          streak.record_activity
          expect(streak.current_streak).to eq(1)
        end

        it '開始日と終了日が今日になる' do
          streak.record_activity
          expect(streak.start_date).to eq(Date.today)
          expect(streak.end_date).to eq(Date.today)
        end
      end
    end

    describe '#display_streak' do
      it 'current_streakの値を返す' do
        streak.current_streak = 5
        expect(streak.display_streak).to eq(5)
      end

      it 'current_streakがnilの場合は0を返す' do
        streak.current_streak = nil
        expect(streak.display_streak).to eq(0)
      end
    end

    describe '#days_since_last_post' do
      it '最終投稿日からの経過日数を返す' do
        streak.update(end_date: Date.today - 3.days)
        expect(streak.days_since_last_post).to eq(3)
      end

      it 'end_dateがnilの場合はnilを返す' do
        streak.update(end_date: nil)
        expect(streak.days_since_last_post).to be_nil
      end
    end

    describe '#active?' do
      it '最終投稿日が今日なら活動中と判定' do
        streak.update(end_date: Date.today)
        expect(streak.active?).to be true
      end

      it '最終投稿日が昨日なら活動中と判定' do
        streak.update(end_date: Date.yesterday)
        expect(streak.active?).to be true
      end

      it '最終投稿日が2日以上前なら活動中でないと判定' do
        streak.update(end_date: Date.today - 2.days)
        expect(streak.active?).to be false
      end

      it '最終投稿日がnilなら活動中でないと判定' do
        streak.update(end_date: nil)
        expect(streak.active?).to be false
      end
    end
  end
end
