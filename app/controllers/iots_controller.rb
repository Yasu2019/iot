class IotsController < ApplicationController
  require 'csv'
  def iot
    timetoday=Time.now.strftime("%Y_%m_%d")

    
    #CSVで取り込んだデータを綺麗なグラフで表示する
    #https://toranoana-lab.hatenablog.com/entry/2018/11/27/182518
    

    data = []
    data_temp = []

    #ファイルやディレクトリが存在するか調べる (File.exist?, Dir.exist?)
    #https://maku77.github.io/ruby/io/file-exist.html
    if File.file?('/myapp/db/record/'+timetoday+'SHT31Temp.csv')
        CSV.foreach('/myapp/db/record/'+timetoday+'SHT31Temp.csv', headers: true) do |row|
          data=[row[0],row[1]]
          data_temp.push(data)
        end
        @temp = data_temp
    end

    data = []
    data_humi = []
    CSV.foreach('/myapp/db/record/'+timetoday+'SHT31Humi.csv', headers: true) do |row|
      data=[row[0],row[1]]
      data_humi.push(data)
    end
    @humi = data_humi

    data = []
    data_komatsu25t3_shot = []
    CSV.foreach('/myapp/db/record/'+timetoday+'ShotKomatsu25t3.csv', headers: true) do |row|
      data=[row[0],row[1]]
      data_komatsu25t3_shot.push(data)
    end
    @komatsu25t3_shot = data_komatsu25t3_shot
   
    data = []
    data_komatsu25t3_spm = []
    CSV.foreach('/myapp/db/record/'+timetoday+'SPMKomatsu25t3.csv', headers: true) do |row|
      data=[row[0],row[1]]
      data_komatsu25t3_spm.push(data)
    end
    @komatsu25t3_spm = data_komatsu25t3_spm

    data = []
    data_komatsu25t3_chokotei = []
    CSV.foreach('/myapp/db/record/'+timetoday+'StampingchokoteiKomatsu25t3.csv', headers: true) do |row|
      data=[row[0],row[1]]
      data_komatsu25t3_chokotei.push(data)
    end
    @komatsu25t3_chokotei = data_komatsu25t3_chokotei

    data = []
    data_komatsu25t3_jyotai = []
    CSV.foreach('/myapp/db/record/'+timetoday+'JYOTAIKomatsu25t3.csv', headers: true) do |row|
      data=[row[0],row[1]]
      data_komatsu25t3_jyotai.push(data)
    end
    @komatsu25t3_jyotai = data_komatsu25t3_jyotai


   





    #timetoday=Time.now.strftime("%Y_%m_%d")
    #file = Dir.glob("C:/Users/mec21/20230213_iot_csv_training_tailwind_daisyui_ancestry_importmap/db/record/"+timetoday+"SHT31Humi.csv")
    #file = Dir.glob("/myapp/db/record/2023_02_18SHT31Temp.csv")
    #IOTデータページ

    @iots=Iot.all 
  end

  def iot_import

    


    # fileはtmpに自動で一時保存される
    Iot.iot_import(params[:file])
    redirect_to iots_url
  end

  def iot_import1
    # fileはtmpに自動で一時保存される
    Iot.iot_import1(params[:file])
    redirect_to iots_url
  end

  def test
      file = params[:file]
        datas = []
        unless file.nil?
          ActiveRecord::Base.transaction do
            CSV.foreach("/myapp/db/record/test.csv", headers: true) do |row|
              datas.append(Hash[row])
            end
          end
        end
        @chartkickgraph = datas[0]
      
  end

  def destroy
    @iot.destroy
    respond_to do |format|
      format.html { redirect_to iots_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
  def iot_params
    params.require(:iot).permit(:date,:data)
  end







end
