import pandas as pd


df = pd.read_csv(r"H:\Project\SQL\amazon\Silver\gold_sales.csv")

print(df.head())


## top 5 products by sales
top_products = df.groupby('category')['quantity'].sum().nlargest(5).reset_index()
print("Top 5 Products by Sales:")
print(top_products)

## top revenue products
top_revenue_products = df.groupby('category')['total_amount'].sum().nlargest(5).reset_index()
print("\nTop 5 Products by Revenue:")
print(top_revenue_products)

## Sales by month
df['order_date'] = pd.to_datetime(df['order_date'])
df['month'] = df['order_date'].dt.to_period('M')
sales_by_category = df.groupby('month')['quantity'].sum().reset_index()
print("\nSales by Month:")
print(sales_by_category)

## prime members v/s non-prime members
prime_sales = df[df['prime_user'] == 'Yes'].groupby('prime_user')['total_amount'].sum().reset_index()
non_prime_sales = df[df['prime_user'] == 'No'].groupby('prime_user')['total_amount'].sum().reset_index()
print("\nPrime Members:")
print(prime_sales)
print("\nNon-Prime Members:")
print(non_prime_sales)

## product ratings by distribution
ratings_distribution = df['rating'].value_counts().reset_index()
ratings_distribution.columns = ['rating', 'count']
print("\nProduct Ratings Distribution:")    
print(ratings_distribution)