require 'csv'

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :phase, only: %i[ graph calendar new edit show index index2 index3 index8 index9 download]

  def search
    @qd = Product.ransack(params[:qd])
    #@products = @qd.result
    @products = @qd.result(distinct: true)
    #@user = current_user
    #binding.pry
  end

  def graph
    #@products=Product.all.page(params[:page]).per(10)
    @products=Product.all
    #@user = current_user    
  end

  def calendar
    #@products=Product.all.page(params[:page]).per(10)
    @products=Product.all
    #@user = current_user    
  end

  
  def new
    @product = Product.new
  end

  def index
    #@products = Product.all
    #@products = Product.page(params[:page]).per(8)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)

  end

  def index2
    @products = Product.where(partnumber:params[:partnumber])
  end

  def index3
    #こちらを選択していた@products=Product.select("DISTINCT ON (partnumber,food) *").page(params[:page]).per(4)
    @products=Product.select("DISTINCT ON (partnumber,stage) *")
    
     @mark_complate="完"
     @mark_WIP="仕掛"
 
     #@user = current_user
  end

  def index4
  #IATF要求事項説明ページ  
  end

  def index8
    @products = Product.where(partnumber:params[:partnumber])
  end

  def index9
    @products=Product.select("DISTINCT ON (partnumber,stage) *")
    
     #@user = current_user
  end

  #RailsでExcel出力しないといけなくなった時の対処法
  #https://www.timedia.co.jp/tech/railsexcel/

  #def download
  #  response.headers["Content-Type"] = "application/excel"
  #  response.headers["Content-Disposition"] = "attachment; filename=\"製品データ.xls\""
      #@date_from = Date.new(2014,3,1)
      #@date_to = Date.new(2014,3,31)
    #@product = Product.find(params[:id])
  #  @products=Product.all
  #end

  def download
    @products=Product.all
    header = ['図番', 'フェーズ', '項目']
    generated_csv = CSV.generate(row_sep: "\r\n") do |csv|
      csv << header
      @products.each do |pro|
        csv << [pro.partnumber, pro.phase, pro.stage]
      end
    end

    send_data generated_csv.encode(Encoding::CP932, invalid: :replace, undef: :replace),
      filename: 'product_list.csv',
      type: 'text/csv; charset=shift_jis'
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: '登録しました。'
    else
     render :new
    end
    
  end

  def show
    #@product = Product.find(params[:id])
    if @product.documents.attached?
      @product.documents.each do |image| 
        fullfilename = rails_blob_path(image)
        @ext = File.extname(fullfilename).downcase
        if @ext== ".jpg" ||  @ext== ".jpeg" ||  @ext== ".png" ||  @ext== ".gif" 
          @Attachment_file = true
        else
          @Attachment_file = false
        end
      end      
    end   
  end


  def edit
      #@product = Product.find(params[:id])
      @title=Product.find(params[:id])
      if @product.documents.attached?
           @product.documents.each do |image| 
             fullfilename = rails_blob_path(image)
             @ext = File.extname(fullfilename).downcase
             if @ext== ".jpg" ||  @ext== ".jpeg" ||  @ext== ".png" ||  @ext== ".gif" 
               @Attachment_file = true
             else
               @Attachment_file = false
             end
           end  
      end    
  end

  def update
    #Rails7で画像の保存にActiveStorage使ってみよう(導入からリサイズまで)
    #https://qiita.com/asasigure/items/311473d25fb3ec97f126

    #ActiveStorage で画像を複数枚削除する方法
    #https://h-piiice16.hatenablog.com/entry/2018/09/24/141510

    #Active Storageを使用して添付ファイル(アップロード)を簡単に管理する
    #https://www.petitmonte.com/ruby/rails_attachment.html

    #@product = Product.find(params[:id])
    #@product.update params.require(:product).permit(:partnumber, documents: []) # POINT
    #redirect_to @product


    product = Product.find(params[:id])
    #if params[:product][:detouch]=='1'
    if params[:product][:detouch]
       params[:product][:detouch].each do |image_id|
        #image = product.files.find(image_id)
        image = @product.documents.find(image_id)
        image.purge
       end
    end
   #【rails】update_attributes→updateを使う
   #update_attributesはrails6.1から削除されたそうです。
   #https://qiita.com/yuka_nari/items/b04c872d4eb2e5347fdb

   if product.update(product_params)
     flash[:success] = "編集しました"
    redirect_to @product
   else
    render :edit
   end



  end

  def destroy
    #@product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_q
    @q = Product.ransack(params[:q])
  end


  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:documentname,:materialcode,:start_time, :deadline_at, :end_at,:status,:goal_attainment_level,:description,:category,:partnumber,:phase,:stage,documents:[])
  end

  def phase

    #@phases=Phase.all
    @phases = Phase.where(ancestry: nil)
    @pha=Phase.all

    
    #ドロップダウンリストの表示が数字のため、単語で表示するためにdropdownlistを設定。※なぜか288行が勝手に追加されるためSKIPで回避
    dropdownlist=[]
    dropdownlist.push("0")
    @pha.each do |p|
        if p.name!="SKIP" 
            dropdownlist.push(p.name)
        end
    end 
    @dropdownlist=dropdownlist

    phases_test=[]
    @pha.each do |p|
    phases_test.push(Phase.find(p.id).children)
    #@phases_test=Phase.find(p.id).children
    end
    @phases_test=phases_test

    
    #@phases1= Phase.find(1).children   # 製品
    #@phases2= Phase.find(2).children   # 文書
    #@phases3= Phase.find(3).children   # フェーズ1
    #@phases4= Phase.find(4).children # フェーズ2
    #@phases5= Phase.find(5).children # フェーズ3
    #@phases6= Phase.find(6).children # フェーズ4
    #@phases7= Phase.find(7).children # フェーズ5
    #@phases8= Phase.find(8).children # PPAP
    #@phases9= Phase.find(9).children # 8.3設計・開発
    #@phases10= Phase.find(10).children # 文書計画
    #@phases11= Phase.find(11).children # プロセス管理図
    #@phases12= Phase.find(12).children # 規定
    #@phases13= Phase.find(13).children # フロー
    #@phases14= Phase.find(14).children # 手順書
    #@phases15= Phase.find(15).children # 新規見直し記録
    #@phases16= Phase.find(16).children # 営業部
    #@phases17= Phase.find(17).children # 管理部
    #@phases18= Phase.find(18).children # 生産技術課
    #@phases19= Phase.find(19).children # 設計課
    #@phases20= Phase.find(20).children # プレス
    #@phases21= Phase.find(21).children # 表面処理
    #@phases22= Phase.find(22).children # 品質保証部
    #@phases23= Phase.find(23).children # 金型課
    #@phases24= Phase.find(24).children # 内部監査
    #@phases25= Phase.find(25).children # 購買先管理
    #@phases26= Phase.find(26).children # 顧客固有要求事項/外部文書
    #@phases27= Phase.find(27).children # 材料仕様書
    #@phases28= Phase.find(28).children # 顧客満足/SPR
    #@phases29= Phase.find(29).children # スキルマップ


  
  end


end