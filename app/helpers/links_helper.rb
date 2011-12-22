module LinksHelper
  
  def create_List_of_links(linkID)
      return Link.find(linkID)
  end
  
  def add_link_return_ID(link)
    @li = Link.new(:link => link)
    if @li.save
      return Link.find(@li).id
    end
  end
end
