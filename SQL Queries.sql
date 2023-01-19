Query 1
------------------------------------------
SELECT grommet_products.product_name, grommet_products.product_img_url, grommet_products.product_url, grommet_products.product_price_min, grommet_products.product_short_description
FROM ((grommet_products
JOIN grommet_product_categories ON grommet_products.id = grommet_product_categories.product_id)
JOIN grommet_gifts_categories ON grommet_product_categories.product_category_id = grommet_gifts_categories.id) WHERE grommet_gifts_categories.sub_category='Jewelry' AND grommet_products.is_sold_out = false;

--------------------------------------------
Query 2
--------------------------------------------
SELECT grommet_products.product_name, grommet_products.product_img_url, grommet_products.product_url, grommet_products.product_price_min, grommet_products.product_short_description
FROM ((grommet_products
JOIN grommet_product_to_keyword ON grommet_products.id = grommet_product_to_keyword.product_id)
JOIN grommet_product_keywords ON grommet_product_to_keyword.keyword_id = grommet_product_keywords.id) 
WHERE grommet_product_keywords.keyword='Hair accessor' AND grommet_products.is_sold_out = false;

---------------------------------------------
Query 3
---------------------------------------------
SELECT grommet_products.product_name, grommet_products.product_img_url, grommet_products.product_url, grommet_products.product_price_min, grommet_products.product_short_description
FROM ((((grommet_products
JOIN grommet_product_categories ON grommet_products.id = grommet_product_categories.product_id)
JOIN grommet_gifts_categories ON grommet_product_categories.product_category_id = grommet_gifts_categories.id) 
JOIN grommet_product_to_keyword ON grommet_products.id = grommet_product_to_keyword.product_id) 
JOIN grommet_product_keywords ON grommet_product_to_keyword.keyword_id = grommet_product_keywords.id)
WHERE grommet_gifts_categories.sub_category='Beauty & Personal Care' OR grommet_product_keywords.keyword='Aromatherapy' AND grommet_products.is_sold_out = false;