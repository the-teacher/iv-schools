class ReportsController < ApplicationController
  # GET /reports
  def index
    @reports = Report.paginate(:all,
                           :order=>"created_at ASC", #ASC, DESC
                           :page => params[:page],
                           :per_page=>10
                           )
                           
    respond_to do |format|
      format.html # index.haml
    end
  end

  # GET /reports/1
  def show
    @report = Report.find_by_zip(params[:id])

    respond_to do |format|
      format.html # show.haml
    end
  end

  # GET /reports/new
  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.haml
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports
  def create
    @report = @user.reports.new(params[:report])

    respond_to do |format|
      if @report.save
        flash[:notice] = 'report успешно создано.'
        format.html { redirect_to(report_path(@report.zip)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /reports/1
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        flash[:notice] = 'report успешно обновлено.'
        format.html { redirect_to(report_path(@report)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /reports/1
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
    end
  end
end