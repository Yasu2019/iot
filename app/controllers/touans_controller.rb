class TouansController < ApplicationController
  def new
    @touans = TouanCollection.new
  end

  def create
    @touans = TouanCollection.new(touans_params)
    if @touans.save
      #redirect_to root_path
      redirect_to touans_url
    else
      render :new
    end
  end

  def index
    @touans=Touan.all
  end

  

  private

    def touans_params
      params.require(:touans)
    end
  
end


  
#def test
#  @user = current_user
#  mondai1 = Testmondai.where(kajyou:params[:kajyou])
#  @te=Touan.all
#  @te.each do |t|
#  if t.seikai!=nil
#    Touan.find(t.id).destroy

#  end
#  end

#  mondai1.each do |mon|
   
#  Touan.create({
#    user_id:   @user.id,
#    kajyou:    mon.kajyou,
#    mondai_no: mon.mondai_no,
#    rev:       mon.rev,
#    mondai:    mon.mondai,
#    mondai_a:  mon.mondai_a,
#    mondai_b:  mon.mondai_b,
#    mondai_c:  mon.mondai_c,
#    seikai:    mon.seikai,
#    kaisetsu:  mon.kaisetsu
#    })
#  end
#  @touans = Touan.all  
#end


  
#def test_show
    
#  @touans =Touan.all

#end

