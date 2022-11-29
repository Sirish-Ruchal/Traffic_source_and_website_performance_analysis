# SQL project - Traffic source and website performance analysis

# Project Description
This project is based on a e-commerce database where I used SQL to answer some important questions. The company started on 19th March 2012 by introducing just one product (Mr_fuzzy). It is now almost end of 2012 (2012-11-27) and the stakeholders of the company wants to understand how well their website is operating. This project aims to address those stakeholder's questions. There are two major areas that we are focusing on this project. First is on website performance and second will be on traffic source. The database was set up in MySQL Workbench.

**1) Website performance analysis**: This is an important concept for e-commerce business because this helps to identify insights on how well the website in particular is doing and what are the limitations that needs to be addressed. There are several analysis inside website performance analysis however, this project will just deal with 3 of them. Understanding top landing page, Bounce rate and Conversion funnel analysis. 

Top landing page refers to the page in the website where most customers land. Bounce rate is an important metric which explains where from where the business is losing most of their customers. Meaning, from which page most of the customer are leaving the website. This helps to understand which page is underperforming and where website manager should be work on. Then comes conversion funnel analysis where we can track customers journey on the website. For instance, a website has 4 pages (home, product, cart, billing, thank you page). It is important for the website manager to understand how many people travels from home – product, product – cart and so on. This is where conversion funnel analysis comes in play. It quantifies the result and help relevant people understand customer’s journey on the website. 

**2) Traffic source analysis**: Traffic source analysis is about understanding which channel is driving highest quality traffic. Meaning, there source like email, social media, direct search and many kinds of traffic. These directs users to the website and increase the traffic to the website. A high-quality traffic source is the one with high conversion rate. **Conversion rate** is total order from the traffic by total amount of traffic. Conversion rate varies from source to source and device to device (for instance mobile and desktop) which this helps to distinguish quality source from underperforming traffic source. This is helpful for the marketing department as they see the quantified result of their campaign and make the Data Driven Decision Making (DDDM) to minimize cost and maximizing the result. 

The project will answer 8 questions which will revolve around website performance and traffic source analysis. 
1.	The database have 2 driving traffic which are gsearch and bsearch. Gsearch seems to be the one that drives the growth. Therefore, Pull the conversion rate from gsearch traffic for each month till 27th Dec 2012.

https://github.com/Sirish-Ruchal/Traffic_source_and_website_performance_analysis/blob/f1b407f43f1b53818487f5565fee2a79cb3b21c5/traffic_and_website_performance_analysis.sql#L4-L23

This query gives the following result.

![Screen Shot 2022-11-18 at 16 16 45](https://user-images.githubusercontent.com/109921496/202751329-4e2d30dd-f96a-4b76-bfc0-7d844a3941f0.png)

Here the data should be compared with 2nd month in the table as the 1st month started from 19th and this is skew the result. The above table shows that gsearch is actually performing very well. The total session from gsearch was 3574 in the 2nd month whereas, by the end of the year, the monthly session number reached to 8889 which is increment of 148.71%. In terms of orders, in the second month, the gsearch traffic brought 92 orders whereas the 12th month brought 373 order which is an increment of 305.43%. Finally, we can see that there is a steady and constant growth in conversion rate of gsearch traffic which 

2. UTM (Urchin Tracking Module) is what marketer use to track each users and their journey from internet all the way till the orders. This is attached in the website link and pushed on the internet. If you wish to see, search anything on google and click on the first ad. when you click on the website url, you will find the this word "UTM" in it. So next task is to identify result from different UTM campaign. In this case, we have 2 utm_campaigns (brand and nonbrand). Nonbrand is the best performer between these two. This time we have to pull the result from both campaign till the year end. 

https://github.com/Sirish-Ruchal/Traffic_source_and_website_performance_analysis/blob/f1b407f43f1b53818487f5565fee2a79cb3b21c5/traffic_and_website_performance_analysis.sql#L29-L49

This is the SQL code used in Mavenfuzzyfactory database to pull the result.

![Screen Shot 2022-11-19 at 12 04 53](https://user-images.githubusercontent.com/109921496/202849962-3e285fd1-cafe-4eae-b2ef-186b555959f2.png)

We can observe that there is vast difference between number of sessions and order number. Surely nonbrand is performing well. However, the conversion rate speaks otherwise. The conversion rate from the traffic coming from brand utm campaign is significantly higher than nonbrand.

3. Now, the conversion rate will be pull and divide them into device type. In this case, we have mobile and desktop. To identify which device type performs well in this business. 

[![Screen Shot 2022-11-19 at 12 14 16](https://user-images.githubusercontent.com/109921496/202850337-e2cbf1cf-0d2e-4a79-9c13-5ee7c3426cb5.png)](https://github.com/Sirish-Ruchal/Traffic_source_and_website_performance_analysis/blob/f1b407f43f1b53818487f5565fee2a79cb3b21c5/traffic_and_website_performance_analysis.sql#L54-L74)

This code bring the result as below:

![Screen Shot 2022-11-19 at 12 15 50](https://user-images.githubusercontent.com/109921496/202850378-ffcaee90-2402-41da-9067-941bf3539ea5.png)

The above table demonstrates that desktop is the major driver of traffic and sales for this business. the difference in total sessions, order number and conversion rate are vastly different in desktop from mobile. 

4. We have realised that the gsearch is the major driver for increasing the number of sessions in the website. But what is the difference between gsearch and bsearch? Is there any improvement in bsearch and if there is, by how much? Let’s find out.
 
![Screen Shot 2022-11-19 at 12 27 54](https://user-images.githubusercontent.com/109921496/202850816-ecf595ed-5a53-4794-897e-f7feee9e2b99.png)

![Screen Shot 2022-11-19 at 12 29 16](https://user-images.githubusercontent.com/109921496/202850861-eb3b56ce-e03f-455b-a1fb-67b970dec984.png)

Seems like initially, there was a great difference between gsearch and bsearch. But by the end of the year, the difference is greatly reduced and bsearch showed great progress. 

5. We have seen difference between device, utm_source and utm_campaign. Now, let summarize the everything to see the aggregate result. Meaning, next task will be to pull the overall conversion rate without limiting with any metric. This will be last task for traffic source analysis in this project.

![Screen Shot 2022-11-19 at 13 01 04](https://user-images.githubusercontent.com/109921496/202852100-d835beb6-181c-44b6-9e69-f29880393163.png)

![Screen Shot 2022-11-19 at 13 02 07](https://user-images.githubusercontent.com/109921496/202852134-f7a4c8e0-705d-40cb-9941-a3bfb217a5ec.png)

It looks like company have steady growth since month 1 of operation. However, a point to be noted is that November shows significant rise in Session, Orders and Conversion rate. There is high chance that this is effect of holiday season where the sales is generally higher than other months. 

**Summary of Traffic source analysis**: After analysing the traffic source from different perspective, it seems like gsearch source, nonbrand campaign and desktop from device seems most important aspect to this business. They are the ones that have higher sessions and orders. In case of campaign, currently, nonbrand is an important campaign however, the pace in improvement from brand campaigns have a promising conversion rate. Finally, conversion rate have steady growth and the year 2013 seems promising and website traffic can be significantly higher than what it is right now.

6. **Website Performance Analysis**: Let’s move away from traffic source analysis and see what story does numbers from website tells. On 2012-06-19, website manager introduced another landing page apart from ‘/home’ which was ‘/lander-1’. We are tasked to pull effect created by both the landing page. The next task requires to limit the date range from ‘2012-06-19’ to ‘2012-11-27’. This is the time frame when both landing pages were live and website sessions were almost equally divided between them. In short, it helps to pull unbiased result. 

Here the codes are presented in 2 separate screen shot:
![Screen Shot 2022-11-19 at 14 21 42](https://user-images.githubusercontent.com/109921496/202855438-5d68bd11-d67c-4745-9455-fd0dfc1bdce8.png)
![Screen Shot 2022-11-19 at 14 22 32](https://user-images.githubusercontent.com/109921496/202855480-553d3594-bbd2-4308-95d6-a04f377b6794.png)

![Screen Shot 2022-11-19 at 14 26 14](https://user-images.githubusercontent.com/109921496/202855661-fda55678-4758-472e-8733-460247b11c04.png)

This table shows that there are almost equal amount of users visited in /home and /lander-1. However, the conversion rate is slightly different. Compared to /home, /lander-1 have generated 27.51% higher conversion rate. Meaning, lander-1 address the customer expectation better. 

7. Since we know that /lander-1 is better performer than /home, now let’s see the customer journey landing in each landing page (/home,/lander-1). Pull the conversion funnel of the website sessions landing in both landing page. 
 
![Screen Shot 2022-11-19 at 14 45 30](https://user-images.githubusercontent.com/109921496/202856589-67f14232-befe-4ed1-88af-924fcffdf57f.png)
![Screen Shot 2022-11-19 at 14 46 52](https://user-images.githubusercontent.com/109921496/202856644-1a8886fa-fd8f-4f25-b79b-d3246cf31d78.png)
![Screen Shot 2022-11-19 at 14 47 12](https://user-images.githubusercontent.com/109921496/202856661-980d677c-2455-43b3-8283-7a8c6430b5c9.png)

Now the result table:
![Screen Shot 2022-11-19 at 14 48 21](https://user-images.githubusercontent.com/109921496/202856699-554c3389-06c7-4673-8da6-96cdc89db272.png)
Here we can observe that /home loses large number of user when going to the product page. This can mean that customer found it difficult or not motivated to move to the product page. This type of analysis help website manager to understand which area need improvement and the part of website that is giving optimum performance. By the way, this is my favorite analysis in this project. 

8. Similar to above change, the website manager made a change in billing page too. A new billing page was introduced on ‘2012-09-10’. Website manager made an hypothesis that change in billing page will be increase in number of order and people will be motivated to checkout. Therefore, this task is to bring the result on ‘2012-11-27’ and compare if their hypothesis worked. 

![Screen Shot 2022-11-19 at 15 18 35](https://user-images.githubusercontent.com/109921496/202857931-09993334-0e8f-413e-b594-4990f6016660.png)

![Screen Shot 2022-11-19 at 15 19 20](https://user-images.githubusercontent.com/109921496/202857976-de0b3859-f7fc-42ef-9de3-6f31a140ade4.png)

The result shows that the hypothesis is true. users are converted into customer and in average, new billing page is generating $8.51 more than previous billing page. In that period, there were 1193 session that landed on both billing pages. Meaning the new billing page can generate *1193 times 8.51* which is $10152 more than previous billing page. 

**Summary**: This was some of the website performance analysis that provide insights of a website. Understanding where website is losing users and understanding the reason can help enhance the website for better user experience.


