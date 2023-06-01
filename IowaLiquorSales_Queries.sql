-- Liquor Sales Measures
--1. Sales $
select lstr.Store_Name,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by Sales;

--2 Sales Volume(Gallons)
select lstr.Store_Name,sum(itm.Volume_Sold_Gallons) SalesVolume_Gallons
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by SalesVolume_Gallons;

--3 Sales Volume(Bottles)
select lstr.Store_Name,sum(itm.Bottles_Sold) SalesVolume_Bottles
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by SalesVolume_Bottles desc;

--4 Gross profit (RetailPrice-Cost)
select lstr.Store_Name,Concat('$',sum(itm.State_Bottle_Retail-itm.State_Bottle_Cost)) GrossProfit
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by GrossProfit desc;

--5 Sales Per Capita -- Hold
select ctyr.City,(sum(itm.Sale_Dollars)/sum(ctyr.Population)) SalesPerCapita
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join FCT_iowa_city_population_by_year ctyr on (ctyr.City_SK=lstr.City_SK)
group by ctyr.City
order by SalesPerCapita desc;


--Q2. Liquor Sales by time
--1 Total
select FORMAT(hdr.Invoice_Date,'MM/dd/yyyy') Total ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'MM/dd/yyyy')
order by Sales;

--2 Year
select FORMAT(hdr.Invoice_Date,'yyyy') "Year" ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy')
order by Sales;

--3 Year, Month
select FORMAT(hdr.Invoice_Date,'yyyy/MM') YearMonth ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy/MM')
order by Sales;

--4 (YoY)
select FORMAT(hdr.Invoice_Date,'yyyy') "Year" ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy')
order by Sales;


--3 Liquor Sales by dimension
--1. Store

select lstr.Store_Name,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by Sales;

--2 County
select cnty.County,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_county cnty on (cnty.County_SK=lstr.County_SK)
group by cnty.County
order by Sales;

--3 City
select cty.City,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_city cty on (cty.City_SK=lstr.City_SK)
group by cty.City
order by Sales;

--4 Category

select cat.Category_Name Category,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Product_Categories cat on (cat.Category_SK=prd.Category_SK)
group by cat.Category_Name
order by Sales;

--5 Item
select prd.Item_Description Item,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
group by prd.Item_Description
order by Sales;

--6 Vendor
select vnd.Vendor_Name Vendor,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Vendors vnd on (vnd.Vendor_SK=prd.Vendor_SK)
group by vnd.Vendor_Name
order by Sales;



-- Top 20 stores (all-time)select top 20 lstr.Store_Name,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by Sales desc;

-- Top 20 cities (all-time)
select top 20 cty.City,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_city cty on (cty.City_SK=lstr.City_SK)
group by cty.City
order by Sales desc;

-- Top 10 counties (all-time)

select top 20 cnty.County,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_county cnty on (cnty.County_SK=lstr.County_SK)
group by cnty.County
order by Sales desc;

-- Top 20 categories (all-time)
select top 20 cat.Category_Name Category,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Product_Categories cat on (cat.Category_SK=prd.Category_SK)
group by cat.Category_Name
order by Sales desc;

-- Top 50 items (all-time)
select  top 20 prd.Item_Description Item,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
group by prd.Item_Description
order by Sales desc;

--6 Top 20 vendor (all-time)
select top 20 vnd.Vendor_Name Vendor,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Vendors vnd on (vnd.Vendor_SK=prd.Vendor_SK)
group by vnd.Vendor_Name
order by Sales desc;
