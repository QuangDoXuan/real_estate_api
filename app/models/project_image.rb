class ProjectImage < ApplicationRecord
  belongs_to :project
  mount_uploader :image, ThumbnailUploader

  def self.createProjectImage(img, project_id)
    project_img = ProjectImage.create(image: img, project_id: project_id)
    project_img.name = ENV['URL'] + "/uploads/project_image/image/" + project_img.id.to_s + "/" + project_img.image.url.split("/")[-1]
    project_img.save
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
