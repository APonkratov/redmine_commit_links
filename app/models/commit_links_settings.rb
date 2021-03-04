class CommitLinksSettings < ActiveRecord::Base

  scope :for_project, -> (project) {
    proj_id = project.is_a?(Class) ? project.id : project
    where(:project_id => proj_id)
  }

  scope :settings_for_project, -> (proj_id) {
    for_project(proj_id).first_or_initialize(RedmineCommitLinks.default_settings)
  }

end
