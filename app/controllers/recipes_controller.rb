class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    prompt = params[:prompt]

    ai_response = RubyLLM.chat.ask("
      Generate a simple recipe based on this request: #{prompt}.
      Return JSON with these keys: title, description, prep_time, cook_time.
      Do NOT include ingredients yet.
    ")

    data = JSON.parse(ai_response.content) rescue {}

    @recipe = current_user.recipes.new(
      title: data["title"] || "Untitled recipe",
      description: data["description"] || "No description",
      prep_time: data["prep_time"] || 10,
      cook_time: data["cook_time"] || 10
    )

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe generated and saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe removed from your cookbook."
  end
end
