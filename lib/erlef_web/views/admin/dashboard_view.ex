defmodule ErlefWeb.Admin.DashboardView do
  use ErlefWeb, :view

  def small_info_box(title, about, icon, link, box_type \\ "info") do
    ~E"""
    <div class="col-lg-3 col-6">
      <!-- small card -->
      <div class="small-box bg-<%= box_type %>">
        <div class="inner">
          <h3><%= title %></h3>

          <p><%= about %></p>
        </div>
        <div class="icon">
          <i class="fas <%= icon %>"></i>
        </div>
        <a href="<%= link %>" class="small-box-footer">
          More info <i class="fas fa-arrow-circle-right"></i>
        </a>
      </div>
      </div>
    """
  end
end
