PadrinoTodos::Admin.controllers :todos do
  get :index do
    @title = "Todos"
    @todos = Todo.all
    render 'todos/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'todo')
    @todo = Todo.new
    render 'todos/new'
  end

  post :create do
    @todo = Todo.new(params[:todo])
    if (@todo.save rescue false)
      @title = pat(:create_title, :model => "todo #{@todo.id}")
      flash[:success] = pat(:create_success, :model => 'Todo')
      params[:save_and_continue] ? redirect(url(:todos, :index)) : redirect(url(:todos, :edit, :id => @todo.id))
    else
      @title = pat(:create_title, :model => 'todo')
      flash.now[:error] = pat(:create_error, :model => 'todo')
      render 'todos/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "todo #{params[:id]}")
    @todo = Todo[params[:id]]
    if @todo
      render 'todos/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'todo', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "todo #{params[:id]}")
    @todo = Todo[params[:id]]
    if @todo
      if @todo.modified! && @todo.update(params[:todo])
        flash[:success] = pat(:update_success, :model => 'Todo', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:todos, :index)) :
          redirect(url(:todos, :edit, :id => @todo.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'todo')
        render 'todos/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'todo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Todos"
    todo = Todo[params[:id]]
    if todo
      if todo.destroy
        flash[:success] = pat(:delete_success, :model => 'Todo', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'todo')
      end
      redirect url(:todos, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'todo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Todos"
    unless params[:todo_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'todo')
      redirect(url(:todos, :index))
    end
    ids = params[:todo_ids].split(',').map(&:strip)
    todos = Todo.where(:id => ids)
    
    if todos.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Todos', :ids => "#{ids.join(', ')}")
    end
    redirect url(:todos, :index)
  end
end
