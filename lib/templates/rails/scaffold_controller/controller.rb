<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show
    @<%= singular_table_name %> = set_<%= singular_table_name %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "form_params") %>
    
    if @<%= orm_instance.save %>
      redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} created.'" %>
    else
      render 'new'
    end
  end
  
  def edit
    @<%= singular_table_name %> = set_<%= singular_table_name %>
  end

  def update
    @<%= singular_table_name %> = set_<%= singular_table_name %>
    
    if @<%= orm_instance.update("form_params") %>
      redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} updated.'" %>
    else
      render 'edit'
    end
  end

  def destroy
    @<%= singular_table_name %> = set_<%= singular_table_name %>
    
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} destroyed.'" %>
  end

  private
    def set_<%= singular_table_name %>
      <%= orm_class.find(class_name, "params[:id]") %>
    end

    def <%= "form_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
