class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = set_project
  end

  def new
    @project = Project.new
  end

  def edit
    @project = set_project
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      redirect_to @project, notice: 'Project created.'
    else
      render 'new'
    end
  end

  def update
    @project = set_project
    
    if @project.update(project_params)
      redirect_to @project, notice: 'Project updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @project = set_project
    
    @project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def set_project
      Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :owner_id)
    end
end
