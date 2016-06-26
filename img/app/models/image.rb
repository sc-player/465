class Image < ActiveRecord::Base
  @@imgcounter=0
  belongs_to :user
  def image_file=(fileobj)
    if fileobj.size>0
      @image_file = fileobj
      self.filename=createFileName(fileobj.original_filename)
    end
  end

  private
    def createFileName(filename)
      @@imgcounter+=1
      @@imgcounter-1+filename
    end
end
