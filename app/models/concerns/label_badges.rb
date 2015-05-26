module LabelBadges
  extend ActiveSupport::Concern

  included do |base|

    %w(american british).each do |name|
      base.badge "#{name}_label" do
        on :after_proposal_committed
        subject_name :proposals
        condition do |model|
          if model.user
            model.has_label?(name.titleize)
          else
            false
          end
        end
      end
    end
  end

  def has_label?(label_name)
    self.labels.where(id: Label.where(name: label_name).first.try(:id)).any?
  end
end
