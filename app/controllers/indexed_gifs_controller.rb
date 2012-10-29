class IndexedGifsController < ApplicationController
  # GET /indexed_gifs
  # GET /indexed_gifs.json
  def index
    @indexed_gifs = IndexedGif.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @indexed_gifs }
    end
  end

  # GET /indexed_gifs/1
  # GET /indexed_gifs/1.json
  def show
    @indexed_gif = IndexedGif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @indexed_gif }
    end
  end

  # GET /indexed_gifs/new
  # GET /indexed_gifs/new.json
  def new
    @indexed_gif = IndexedGif.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @indexed_gif }
    end
  end

  # GET /indexed_gifs/1/edit
  def edit
    @indexed_gif = IndexedGif.find(params[:id])
  end

  # POST /indexed_gifs
  # POST /indexed_gifs.json
  def create
    @indexed_gif = IndexedGif.new(params[:indexed_gif])

    respond_to do |format|
      if @indexed_gif.save
        format.html { redirect_to @indexed_gif, notice: 'Indexed gif was successfully created.' }
        format.json { render json: @indexed_gif, status: :created, location: @indexed_gif }
      else
        format.html { render action: "new" }
        format.json { render json: @indexed_gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /indexed_gifs/1
  # PUT /indexed_gifs/1.json
  def update
    @indexed_gif = IndexedGif.find(params[:id])

    respond_to do |format|
      if @indexed_gif.update_attributes(params[:indexed_gif])
        format.html { redirect_to @indexed_gif, notice: 'Indexed gif was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @indexed_gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indexed_gifs/1
  # DELETE /indexed_gifs/1.json
  def destroy
    @indexed_gif = IndexedGif.find(params[:id])
    @indexed_gif.destroy

    respond_to do |format|
      format.html { redirect_to indexed_gifs_url }
      format.json { head :no_content }
    end
  end
end
