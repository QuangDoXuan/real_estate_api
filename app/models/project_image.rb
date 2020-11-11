class ProjectImage < ApplicationRecord
  belongs_to :project

  def self.createProjectImage(img, project_id)
    project_img = ProjectImage.create(name: img[:image_name], project_id: project_id)
    project_img
  end
  
  def self.updateProjectImage(img, project_id)
    if img[:id].present?
      project_img = ProjectImage.find(img[:id])
      if img[:is_delete] == true
        project_img.delete
      elsif img[:is_change] == true
        project_img.update(name: img[:image_name])
      end
    else
      ProjectImage.create(name: img[:image_name], project_id: project_id)
    end
  end
end
