PadrinoTodos::Api.controllers :todos, map: 'todos' do
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index, provides: [:json] do
    todos = Todo.all
    { todos: todos }.to_json
  end

  get :show, map: ':id', provides: [:json] do
    todo = Post[params[:id]]
    { todo: todo }.to_json
  end

  post :create, map: '', csrf_protection: false, provides: [:json] do
    return '{}' if todo_params['todo'].nil?

    todo = Todo.create todo_params['todo']
    { todo: todo }.to_json
  end

  put :update, map: ':id', csrf_protection: false, provides: [:json] do
    todo = Todo[params[:id]]
    return '{}' if todo.nil?

    todo.update todo_params['todo']
    { todo: todo }.to_json
  end

  delete :destroy, map: ':id', csrf_protection: false, provides: [:json] do
    post = Todo[params[:id]]
    post.delete unless post.nil?
    status 204
    body ''
  end
end

def todo_params
  @todo_params ||= JSON.parse(request.body.read)
end
