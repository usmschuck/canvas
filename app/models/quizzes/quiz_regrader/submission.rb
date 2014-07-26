#
# Copyright (C) 2013 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

class Quizzes::QuizRegrader::Submission

  attr_reader :submission, :question_regrades

  def initialize(hash)
    @submission = hash.fetch(:submission)
    @question_regrades = hash.fetch(:question_regrades)
  end

  def regrade!
    return unless answers_to_grade.size > 0

    # regrade all previous versions
    submission.attempts.last_versions.each do |version|
      Quizzes::QuizRegrader::AttemptVersion.new(
        :version => version,
        :question_regrades => question_regrades).regrade!
    end

    # save this version
    rescored_submission.save_with_versioning!
  end

  def rescored_submission
    previous_score = submission.score_before_regrade || submission.score
    submission.score += answers_to_grade.map(&:regrade!).inject(&:+) || 0
    submission.score_before_regrade = previous_score
    submission.quiz_data = regraded_question_data
    submission
  end

  private

  def answers_to_grade
    @answers_to_grade ||= submitted_answers.map do |answer|
      Quizzes::QuizRegrader::Answer.new(answer, question_regrades[answer[:question_id]])
    end
  end

  def submitted_answers
    @submitted_answers ||= submission.submission_data.select do |answer|
      question_regrades[answer[:question_id]]
    end
  end

  def submitted_answer_ids
    @submitted_answer_ids ||= submitted_answers.map { |q| q[:question_id] }.to_set
  end

  REGRADE_KEEP_FIELDS = (%w{id position name question_name published_at}).to_set

  def regraded_question_data
    submission.quiz_data.map do |question|
      id = question[:id]
      if submitted_answer_ids.include?(id)
        question.keep_if {|k, v| REGRADE_KEEP_FIELDS.include?(k) }

        quiz_question = question_regrades[id].quiz_question
        data  = quiz_question.question_data
        group = quiz_question.quiz_group

        if group && group.pick_count
          data[:points_possible] = group.question_points
        end

        question.merge(data.to_hash)
      else
        question
      end
    end
  end
end