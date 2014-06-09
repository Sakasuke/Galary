# coding: utf-8

class CtrlController < ApplicationController
  require 'kconv'
  require 'matrix'
  
  def index 
    #index(トップページが呼び出された時に動作する関数)
    Dir.pwd
    Dir.chdir("./../../public/images")
      randNum =  Dir.glob("*.jpg").count   
      @rand = []
      @number = []
    
      for i in 1..randNum
        @number << i
      end
     
      for i in 1..randNum
        rr = rand(@number.size)
        @rand << @number.slice!(rr).to_s
      end
    #for randRepeat in 1..15
    #  @rand[randRepeat] = rand(10).to_s
    #end
  end
  
  def viewer     
      Dir.chdir("./../../public/images")
      randNum =  Dir.glob("*.jpg\0*.jpeg\0*.png").count   
      @rand = []
      @number = []
      
      for i in 1..randNum
        @number << i
      end
     
      for i in 1..randNum
        rr = rand(@number.size)
        @rand << @number.slice!(rr).to_s
      end
  end
  
  def upload_process
    file = params[:upfile].each do |file|
      name = file.original_filename
      perms = ['.jpg','.jpeg','.gif','.png','.raw']
    
      if !perms.include?(File.extname(name).downcase)
        result = 'アップロードできるのは画像ファイルのみ'
      elsif file.size > 10.megabyte
        result = 'ファイルサイズは10MBまで'
      else 
        name = name.kconv(Kconv::SJIS,Kconv::UTF8)
      
         
        File.open("./../../public/images/#{name}",'wb') { |f| f.write(file.read)}
      
        Dir.chdir("./../../public/images")
        fileCounter =  Dir.glob("*.jpg\0*.jpeg\0*.png").count
        File.rename("./../../public/images/#{name}","./../../public/images/#{fileCounter}.jpg")
        result = []
        result << "#{name.toutf8}をアップロード完了"
      end
      #render :text => result
    end
  end
end
