import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(r"H:\Project\SQL\amazon\Silver\gold_sales.csv")    
print(df.head())

## visulas for top 5 products by sales
top_products = df.groupby('category')['quantity'].sum().nlargest(5).reset_index()
plt.figure(figsize=(10, 6)) 
sns.barplot(x='quantity', y='category', data=top_products, palette='viridis')
plt.title('Top 5 Products by Sales')    
plt.xlabel('Quantity Sold')
plt.ylabel('Product Category')
plt.tight_layout()
plt.savefig('top_products_by_sales.png')    
plt.show()

## visulas for top 5 revenue products
top_revenue_products = df.groupby('category')['total_amount'].sum().nlargest(5).reset_index()
plt.figure(figsize=(10, 6))     
sns.barplot(x='total_amount', y='category', data=top_revenue_products, palette='plasma')
plt.title('Top 5 Products by Revenue')
plt.xlabel('Total Revenue')
plt.ylabel('Product Category')
plt.tight_layout()
plt.savefig('top_revenue_products.png')
plt.show()




## visulas for prime members vs non-prime members
prime_sales = df[df['prime_user'] == 'Yes'].groupby('prime_user')['total_amount'].sum().reset_index()
non_prime_sales = df[df['prime_user'] == 'No'].groupby('prime_user')['total_amount'].sum().reset_index()
plt.figure(figsize=(8, 5))
sns.barplot(x='prime_user', y='total_amount', data=pd.concat([prime_sales, non_prime_sales]), palette='coolwarm')
plt.title('Prime Members vs Non-Prime Members')
plt.xlabel('Prime User Status')
plt.ylabel('Total Revenue')
plt.tight_layout()
plt.savefig('prime_vs_non_prime_sales.png')
plt.show()

## sale by category
category_sales = df.groupby('category').agg({'quantity': 'sum'}).reset_index()
plt.figure(figsize=(12, 6))
sns.barplot(x='category', y='quantity', data=category_sales, color='blue', label='Quantity Sold')
plt.title('Sales by Category')
plt.xlabel('Product Category')
plt.ylabel('Amount')
plt.legend()
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('sales_by_category.png')
plt.show()

## revenue by category
category_sales = df.groupby('category').agg({'total_amount': 'sum'}).reset_index()
plt.figure(figsize=(12, 6))
sns.barplot(x='category', y='total_amount', data=category_sales, color='blue', label='Quantity Sold')
plt.title('Revenue by Category')
plt.xlabel('Product Category')
plt.ylabel('Amount')
plt.legend()
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('revenue_by_category.png')
plt.show()


## buyers by gender
buyers_by_gender = df.groupby('gender')['quantity'].sum().reset_index()
plt.figure(figsize=(8, 5))
sns.barplot(data=df,x='gender', y='quantity', palette='Set2')
plt.title('Distribution of Buyers by Gender')
plt.xlabel('Gender')
plt.ylabel('Total Revenue')
plt.tight_layout()
plt.savefig('buyers_by_gender.png')
plt.show()  

