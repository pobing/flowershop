class TabflowersController < ApplicationController
  # GET /tabflowers
  # GET /tabflowers.xml
  def index
#    @tabflowers = Tabflower.all
#     @tabflowers=Tabflower.paginate :page =>1, :per_page => 1
    @tabflowers=Tabflower.paginate :page => params[:page], :per_page => 9
    sql="select count(*) from tabflowers"
    @totalTS=Tabflower.count_by_sql(sql)
    totalTS=Tabflower.count_by_sql(sql)
    @currentYS=params[:page]
    @perPage=9
    perPage=9
    if totalTS % perPage!=0
      totalJY=totalTS / perPage+1
    else
      totalJY=totalTS / perPage
    end
    @totalJY=totalJY
    @tabuser=session[:tabuser]
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tabflowers }
    end
  end
    # GET /tabflowers/1
  # GET /tabflowers/1.xml
  def show
 @tabuser=session[:tabuser]
    @tabflower = Tabflower.find(params[:id])
 if @tabuser!=nil
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tabflower }
    end
    end
  end

  # GET /tabflowers/new
  # GET /tabflowers/new.xml
  def new

     @tabuser=session[:tabuser]
    if @tabuser!=nil then
    @tabflower = Tabflower.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tabflower }
    end
    end    
  end

  # GET /tabflowers/1/edit
  def edit
    @tabflower = Tabflower.find(params[:id])
  end

  # POST /tabflowers
  # POST /tabflowers.xml
  def create
     @tabuser=session[:tabuser]
    if @tabuser!=nil then
    @tabflower = Tabflower.new(params[:tabflower])
    respond_to do |format|
      if @tabflower.save
        format.html { redirect_to(@tabflower, :notice => 'Tabflower was successfully created.') }
        format.xml  { render :xml => @tabflower, :status => :created, :location => @tabflower }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tabflower.errors, :status => :unprocessable_entity }
      end
    end
    end    
  end

  # PUT /tabflowers/1
  # PUT /tabflowers/1.xml
  def update
    @tabflower = Tabflower.find(params[:id])
    respond_to do |format|
      if @tabflower.update_attributes(params[:tabflower])
        format.html { redirect_to(@tabflower, :notice => 'Tabflower was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tabflower.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tabflowers/1
  # DELETE /tabflowers/1.xml
  def destroy
    @tabflower = Tabflower.find(params[:id])
    @tabflower.destroy
    respond_to do |format|
      format.html { redirect_to(tabflowers_url) }
      format.xml  { head :ok }
    end
  end


  def addcart
    @tabuser=session[:tabuser]
    if @tabuser!=nil then
    tabflower=Tabflower.find(params[:id])
    if(session[:tabflower_shopping]==nil) then
      session[:tabflower_shopping]=Hash.new
    end
     tabflower_shop=session[:tabflower_shopping]
    if tabflower_shop.has_key?(tabflower) then
      tabflower_shop[tabflower]=tabflower_shop[tabflower]+1
    else
      tabflower_shop[tabflower]=1
    end
      redirect_to :action=>"checkout"
    else
     flash[:notice]="Please first to Login"
    end
  end  

  def checkout
     @tabuser=session[:tabuser]
     if @tabuser!=nil then
     @tabflower_shop=  session[:tabflower_shopping]
     @totalfp=0
     @totalfs=0
     if @tabflower_shop!=nil then
         @tabflower_shop.each do |tabflower,amount|
           if session[:amount]!=nil
             amount=session[:amount].to_i
           end
         @totalfp+=tabflower.fPprice*amount
         @totalfs+=tabflower.fSPrice*amount
         end
     end
     else
       flash[:notice]="You not Login"
     end
  end

  def emptyFlower
    @tabuser=session[:tabuser]
     if @tabuser!=nil then
    session[:tabflower_shopping]=nil
    redirect_to :action=>"checkout"
     end
  end

  def JZ
     @tabuser=session[:tabuser]
     if @tabuser!=nil then
     @tabflower_shop=  session[:tabflower_shopping]
     @totalfp=0
     @totalfs=0
     if @tabflower_shop!=nil then
         @tabflower_shop.each do |tabflower,amount|
         @totalfp+=tabflower.fPprice*amount
         @totalfs+=tabflower.fSPrice*amount
         end
     end
     else
       flash[:notice]="You not Login"
     end
  end

  def tjFriends
    @tabuser=session[:tabuser]
    if @tabuser==nil
      redirect_to :action=>"index"  
    end
  end

  def search
    searchName=params[:tabflower][:fName]
    sql="select * from tabflowers where fName like '%"+searchName+"%'"
    @tabflowers=Tabflower.find_by_sql(sql)
    if @tabflowers==nil
      flash[:notice]="sorry,this Flower is not store"
    end
  end


  def deleteFlower
    id=params[:id]
    @tabuser=session[:tabuser]
    if @tabuser!=nil then
    tabflower=Tabflower.find(params[:id])
    if(session[:tabflower_shopping]==nil) then
      session[:tabflower_shopping]=Hash.new
    end
     tabflower_shop=session[:tabflower_shopping]
    if tabflower_shop.has_key?(tabflower) then
    tabflower_shop.delete(tabflower)   
    end
      redirect_to :action=>"checkout"
    else
     flash[:notice]="Please first to Login"
    end
  end
end

