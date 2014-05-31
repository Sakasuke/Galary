# coding: utf-8

class CtrlController < ApplicationController
  require 'kconv'
  
  def index
    #index(トップページが呼び出された時に動作する関数)
    @rand1 = rand(10).to_s
    @rand2 = rand(10).to_s
    @rand3 = rand(10).to_s
    
  end
  
  def upload_process
    file = params[:upfile]
    
    name = file.original_filename
    
    perms = ['.jpg','.jpeg','.gif','.png','.raw']
    
    if !perms.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみ'
    elsif file.size > 10.megabyte
      result = 'ファイルサイズは10MBまで'
    else 
      name = name.kconv(Kconv::SJIS,Kconv::UTF8)
    
      File.open("public/images/#{name}",'wb') { |f| f.write(file.read)}
    
      result = "#{name.toutf8}をアップロード完了"
    end
  render :text => result
  end
end
