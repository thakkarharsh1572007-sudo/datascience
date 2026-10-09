## Section A: Concept Application

**1. Handling Missing Data and Type Conversion**
Dropping rows is not recommended when 14% of the `delivery_time_mins` data is missing because discarding such a large volume of data can result in significant information loss and introduce bias[cite: 1]. Imputing the data with the median is the best strategy; delivery times naturally exhibit a right-skewed distribution due to rare but extreme delays (e.g., traffic or weather), making the mean heavily skewed by outliers[cite: 1]. 
To correct the `customer_rating` column type from strings to float64, you should use the following Pandas operation[cite: 1]:
`df['customer_rating'] = pd.to_numeric(df['customer_rating'], errors='coerce')` 

**2. Identifying Surge Days with NumPy**
NumPy boolean indexing creates a boolean mask—an array of `True` and `False` values—by evaluating a condition across an entire array simultaneously[cite: 2]. For the surge days scenario, applying the condition `orders > np.mean(orders) + 1.5 * np.std(orders)` generates a mask that is then passed into the matching revenue array (`revenue[mask]`) to extract only the revenues for the flagged days[cite: 1, 2]. This element-wise approach avoids Python loops by leveraging pre-compiled, optimized C code under the hood, allowing operations to be executed in contiguous memory blocks vastly faster than iterating element by element[cite: 2].

**3. Exploratory Data Analysis (EDA) Mapping**
*   **Business Question (a):** Correlating delivery time with customer rating is a **Bivariate analysis**[cite: 2].
    *   *Chart Type:* Seaborn `scatterplot`. A scatterplot displays discrete data points for two continuous numerical variables, perfectly illustrating dispersion and correlation density. A line plot would incorrectly imply a continuous progression or timeline between unrelated order ratings[cite: 2].
*   **Business Question (b):** Distributing average order value across restaurant categories is a **Bivariate analysis** (one numerical, one categorical variable)[cite: 2].
    *   *Chart Type:* Seaborn `boxplot`. Boxplots explicitly display median, quartiles, and outliers across different distinct categories. A line plot cannot effectively depict the distribution spread within disconnected categorical data[cite: 2].

**4. SQL JOIN Strategies for Missing Data**
To generate a report showing every restaurant's name alongside total revenue, including restaurants with zero orders, you must use a **LEFT JOIN** (assuming the `restaurants` table is on the left)[cite: 2]. A LEFT JOIN retains all records from the left table and inserts `NULL` values for unmatched records in the right table. If an **INNER JOIN** were used, any restaurant that hasn't received an order would be completely excluded from the final report because INNER JOINs strictly require matching keys in both tables to return a row[cite: 2].

**5. SQL Window Functions vs. GROUP BY**
The two SQL window functions needed are **`RANK()`** (or `DENSE_RANK()`) to order the delivery agents by completed deliveries, and **`LAG()`** to retrieve the previous row's delivery count for direct comparison[cite: 2]. Window functions with `PARTITION BY` (e.g., `PARTITION BY city`) apply calculations across a defined set of rows related to the current row without collapsing the output[cite: 2]. A `GROUP BY` paired with a self-join or correlated subquery requires evaluating the table multiple times, resulting in complex, hard-to-maintain code and severe performance degradation on large datasets[cite: 2].

**6. SQL Optimization: CTE vs. Nested Subqueries**
A Common Table Expression (CTE) defined via the `WITH` clause improves readability by breaking complex two-step logic (finding top 5 categories, then retrieving full order details) into sequential, named, and reusable blocks[cite: 3]. CTEs are highly debuggable because you can independently run the `WITH` block. A deeply nested subquery inside a `WHERE` clause obscures the logical flow[cite: 3]. However, a nested subquery is generally preferred over a CTE when the operation is extremely simple, single-use, and doesn't require intermediate code reuse, minimizing the structural overhead of defining a CTE block[cite: 3].