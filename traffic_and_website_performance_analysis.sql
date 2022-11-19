Question 1)
Could you pull the monthly trend of order coming from gsearch source?

use mavenfuzzyfactory;
-- date till '2012-11-27'

select 
	min(date(ws.created_at)) as beginning_date,
    count(distinct ws.website_session_id) as total_sessions,
    count(distinct o.order_id) as total_order,
    count(distinct o.order_id)/count(distinct ws.website_session_id)*100 as session_to_order_rate
from 
	website_sessions as ws 
left join 
	orders as o
on 
	o.website_session_id = ws.website_session_id
where 
	utm_source = 'gsearch'
    and ws.created_at <= '2012-11-27'
group by 
	month(ws.created_at)
order by 1;


Question 2)
conduct similar analysis as above but this time split the monthly result between two utm_campaign ('nonbrand' & 'brand')

use mavenfuzzyfactory;
-- date till '2012-11-27'

select 
	min(date(ws.created_at)) as beginning_date,
    ws.utm_campaign,
    count(distinct ws.website_session_id) as total_sessions,
    count(distinct o.order_id) as total_order,
    count(distinct o.order_id)/count(distinct ws.website_session_id)*100 as session_to_order_rate
from 
	website_sessions as ws 
left join 
	orders as o
on 
	o.website_session_id = ws.website_session_id
where 
	utm_source = 'gsearch'
    and ws.created_at <= '2012-11-27'
    and ws.utm_campaign in ('nonbrand','brand') 
group by 
	month(ws.created_at),ws.utm_campaign;

Question 3)
similar analysis as above but this time split by device type between desktop and mobile.
	
use mavenfuzzyfactory;
-- date till '2012-11-27'

select 
	min(date(ws.created_at)) as beginning_date,
    ws.device_type,
    count(distinct ws.website_session_id) as total_sessions,
    count(distinct o.order_id) as total_order,
    count(distinct o.order_id)/count(distinct ws.website_session_id)*100 as session_to_order_rate
from 
	website_sessions as ws 
left join 
	orders as o
on 
	o.website_session_id = ws.website_session_id
where 
	utm_source = 'gsearch'
    and ws.created_at <= '2012-11-27'
    and ws.utm_campaign in ('nonbrand','brand') 
group by 
	month(ws.created_at),ws.device_type;

Question 4) 
traffic source analysis of all the source along side gsearch
-- here null have been removed but there is still option to include that in the query.
use mavenfuzzyfactory;
-- date till '2012-11-27'

-- distinct utm_source: gsearch, bsearch and socialbook

select 
	min(date(created_at)) as frist_DO_month,
    utm_source,
	count(distinct website_session_id) se
from website_sessions
where 
	created_at <= '2012-11-27'
    and utm_source is not null
group by
	month(created_at),utm_source;


Question 5)
Pull sessions to orders rate till '2012-11-27'

use mavenfuzzyfactory;
-- date till '2012-11-27' 
-- business objective: pull session to orders conversion rate till '2012-11-27' 

select 
	min(date(ws.created_at)) as min_date,
    count(distinct ws.website_session_id) as total_sessions,
    count(distinct o.order_id) as total_orders,
    count(distinct o.order_id)/count(distinct ws.website_session_id)*100 as session_to_orders
from website_sessions as ws
left join orders as o
on 
	o.website_session_id = ws.website_session_id
where 
	ws.created_at <= '2012-11-27'
group by 
	month(ws.created_at)

Question 6)
Frot he gsearch lander test, estimate the revenue that the test earned us (look at the lander 1 and home page)
limit the time frame to '2012-06-17' and '2012-07-28'
and min website_oagevuew_id is 23504

-- business question for the gsearch lander test, please estimate the revenue that the test have earned us. 
-- use the non brand revenue and revenue jun 19 to july 28

use mavenfuzzyfactory;

-- first identify the first website_pagview_id when the lander_1 used

select 
	min(website_pageview_id)
from website_pageviews
where pageview_url = '/lander-1';

-- min website_pageview_id = 23504
-- use this to limit the result

drop temporary table if exists landing_website_session_id;
create temporary table landing_website_session_id
select 
	wp.website_session_id,
    min(wp.website_pageview_id) as website_pageview_id
from 
	website_pageviews as wp
inner join 
	website_sessions as ws
on
	wp.website_session_id = ws.website_session_id
where 
	ws.created_at < '2012-07-28'
    and wp.website_pageview_id > '23504'
    and ws.utm_source = 'gsearch'
    and ws.utm_campaign = 'nonbrand'
group by 1;

drop temporary table if exists landing_pages;
create temporary table landing_pages
select 
    l.website_session_id,
    w.pageview_url
from landing_website_session_id as l
left join website_pageviews as w
on l.website_session_id = w.website_session_id
where w.pageview_url in ('/home','/lander-1');

select 
	l.pageview_url,
    count(distinct l.website_session_id) as total_sessions,
    count(distinct o.order_id) as total_orders,
    count(distinct o.order_id)/count(distinct l.website_session_id)*100 as comversion_rate
from landing_pages as l
left join orders as o
on l.website_session_id = o.website_session_id
group by 1;

-- /home: 3.1844 and /lander-1: 4.0605
-- this is increase by 27.5122%



    
    
Question 7)
A/B testing: Pull out hte conversion funnel analysis of /lander-1 and /home. 

use mavenfuzzyfactory;

-- conversion funnel for home and lander 1. the time is between june 19 and july 28.

select -- to identify the minimum website_pageview_id and created_at
	min(website_pageview_id),
    min(created_at)
from website_pageviews
where pageview_url = '/lander-1';

-- minimum website_pageview_id = 23504
-- minimum created_id = 2012-06-19

drop temporary table if exists landing_wsp_id;
create temporary table landing_wsp_id
select 
	wp.website_session_id,
    max(wp.website_pageview_id) as website_pageview
from website_pageviews as wp
left join website_sessions as ws
on ws.website_session_id = wp.website_session_id
where 
	wp.website_pageview_id >= 23504
    and ws.created_at < '2012-07-28'
    and ws.utm_source = 'gsearch'
    and ws.utm_campaign = 'nonbrand'
    and wp.pageview_url in ('/home','/lander-1')
group by 1;

Drop temporary table if exists landing_pages;
create temporary table landing_pages
select 
	website_session_id,
    max(to_home) as to_home_page,
    max(to_lander_1) as to_lander_page,
    max(to_product) as to_product_page,
    max(to_mrfuzzy) as to_mrfuzzy_page,
    max(to_cart) as to_cart_page,
    max(to_shipping) as to_shipping_page,
    max(to_billing) as to_billing_page,
    max(to_thankyou) as to_thankyou_page
From(
select 
	l.website_session_id,
    case when pageview_url = '/home' then 1 else 0 end as to_home,
    case when pageview_url = '/lander-1' then 1 else 0 end as to_lander_1,
    case when pageview_url = '/products' then 1 else 0 end as to_product,
    case when pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end as to_mrfuzzy,
    case when pageview_url = '/cart' then 1 else 0 end as to_cart,
    case when pageview_url = '/shipping' then 1 else 0 end as to_shipping,
    case when pageview_url = '/billing' then 1 else 0 end as to_billing,
    case when pageview_url = '/thank-you-for-your-order' then 1 else 0 end as to_thankyou
from landing_wsp_id as l
left join website_pageviews as wp
on
	l.website_session_id = wp.website_session_id
) as referencee
group by 1;

select 
	case
		when to_home_page = 1 then 'home_page'
		when to_lander_page = 1 then 'lander_1'
        else 'improve your logic idiot' -- that 'idiot' is for me if i mistake
	end as landing_area,
    count(distinct website_session_id) as total_sessions,
    count(distinct case when to_product_page = 1 then website_session_id else null end) as to_product_page,
    count(distinct case when to_mrfuzzy_page = 1 then website_session_id else null end) as to_mrfuzzy_page,
    count(distinct case when to_cart_page = 1 then website_session_id else null end) as to_cart_page,
    count(distinct case when to_shipping_page = 1 then website_session_id else null end) as to_shipping_page,
    count(distinct case when to_billing_page = 1 then website_session_id else null end) as to_billing_page,
    count(distinct case when to_thankyou_page = 1 then website_session_id else null end) as to_thankyou_page
from landing_pages
group by 1
order by 1 desc;
    



question 8
identify estimated hike in average order from billing to billing-2 is exists.

use mavenfuzzyfactory;

select 
	pageview_url,
    count(website_session_id) as total_sessions,
    sum(price_usd)/count(website_session_id) as session_to_orders
from(
select 
	wp.website_session_id,
    wp.pageview_url,
    o.order_id,
    o.price_usd
from website_pageviews as wp
left join orders as o
on
	wp.website_session_id = o.website_session_id
where 
	wp.created_at > '2012-09-10' 
    and wp.created_at < '2012-11-10'
    and wp.pageview_url in ('/billing','/billing-2')
order by 1
) as refer

group by 1;

-- billing generated 22.82
-- billing-1 generated 31.33
-- lift of $8.51

select 
	count(website_session_id)
    -- ,1193*8.51
from website_pageviews
where pageview_url in ('/billing','/billing-2')
and created_at between '2012-10-27' and '2012-11-27'

-- total of 1193
-- lift of 8.51
-- estimated increase in revenue is 10152.43
