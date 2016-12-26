module ApplicationHelper
  def has_bonus_card?
  	current_user&.poster_client
  end

  def order_bonus_card_block(alternative_text, alternative_link)
	if has_bonus_card?
	  return link_to alternative_text, alternative_link, class: "offset-top-35 link link-lg"
	else
	  if user_signed_in?
	    return link_to "Заказать бонусную карту", "/poster_clients/new", class: "offset-top-35 link link-lg"
	  else
	    return link_to "Заказать бонусную карту", "/users/sign_up", class: "offset-top-35 link link-lg"
	  end
	end
  end

  def category_image_tag(category_code)
  	cat_img = 'category/' + category_code + '.jpg'
  	return image_tag cat_img
  end
end
