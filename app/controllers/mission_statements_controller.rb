class MissionStatementsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_mission_statement, only: %i[show edit update]

  def show; end

  def edit
    authorize @mission_statement
  end

  def update
    authorize @mission_statement
    @mission_statement.user = current_user

    if @mission_statement.update(mission_statement_params)
      redirect_to mission_statement_path(@mission_statement), success: success_message(@mission_statement, 'updated')
    else
      flash_error_message
      render :edit
    end
  end

  private

  def set_mission_statement
    @mission_statement = MissionStatement.first_or_initialize
  end

  def mission_statement_params
    params.require(:mission_statement).permit(:content)
  end
end
