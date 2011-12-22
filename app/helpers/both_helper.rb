module BothHelper
  
  def search_linkID_by_tagID(tagID_s)
   @i =	3
   @linkID = []
   until @i == (Both.last.id + 1)
      if tagID_s == Both.find(@i).tagID
      @linkID << Both.find(@i).linkID
      end
     @i +=1
   end
   return @linkID
  end
  
  
end
