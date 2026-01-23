# 📦 Inferência estatística sobre o tempo médio de entrega em pedidos de e-commerce no Brasil

Análise inferencial do tempo de entrega de pedidos de e-commerce no Brasil,
utilizando dados reais da Olist.


---

# 🎯 Objetivo geral

Analisar, por meio de técnicas de inferência estatística, o tempo médio de entrega de pedidos de e-commerce no Brasil, utilizando dados reais da Olist referentes a pedidos efetivamente entregues.

### 🎯 Objetivos específicos: 

- Construir a variável tempo de entrega, em dias, a partir das datas de compra e entrega dos pedidos.
- Realizar uma análise descritiva do tempo de entrega.
- Estimar o tempo médio de entrega por meio de intervalos de confiança.
- Testar hipóteses sobre a média populacional do tempo de entrega.
- Avaliar a adequação dos pressupostos inferenciais, com base em análise gráfica e no Teorema Central do Limite.
- Interpretar os resultados sob a ótica logística, discutindo implicações práticas.

--- 

# 🗂️ Dados
- Fonte: 
- Conjunto: `orders`
- Amostragem aleatória simples (n = 5.000)

# ✅ Passo 1 — Construir a variável tempo de entrega, em dias, a partir das datas de compra e entrega dos pedidos.

#### Importante ressaltar que foi usado na análise apenas os pedidos com status deliverid, uma vez que apenas nesses casos o tempo de entrega pode ser observado. Pedidos com status shipped, invoiced, unavailable etc foram excluídos da observação.

``` 
# 1.1 - Filtrando apenas os pedidos com status delivered:

pedidos_entregues = olist_orders_dataset %>%
  filter(order_status == "delivered")

# 1.2 - Visualizando as 5 primeiras linhas do dataset

View(pedidos_entregues)

```
| # | order_id | customer_id | order_status | order_purchase_timestamp | order_approved_at | order_delivered_carrier_date | order_delivered_customer_date | order_estimated_delivery_date |
|---|----------|-------------|--------------|---------------------------|-------------------|------------------------------|-------------------------------|-------------------------------|
| 1 | e481f51cbdc54678b7cc49136f2d6af7 | 9ef432eb6251297304e76186b10a928d | delivered | 2017-10-02 10:56:33 | 2017-10-02 11:07:15 | 2017-10-04 19:55:00 | 2017-10-10 21:25:13 | 2017-10-18 |
| 2 | 53cdb2fc8bc7dce0b6741e2150273451 | b0830fb4747a6c6d20dea0b8c802d7ef | delivered | 2018-07-24 20:41:37 | 2018-07-26 03:24:27 | 2018-07-26 14:31:00 | 2018-08-07 15:27:45 | 2018-08-13 |
| 3 | 47770eb9100c2d0c44946d9cf07ec65d | 41ce2a54c0b03bf3443c3d931a367089 | delivered | 2018-08-08 08:38:49 | 2018-08-08 08:55:23 | 2018-08-08 13:50:00 | 2018-08-17 18:06:29 | 2018-09-04 |
| 4 | 949d5b44dbf5de918fe9c16f97b45f8a | f88197465ea7920adcdbec7375364d82 | delivered | 2017-11-18 19:28:06 | 2017-11-18 19:45:59 | 2017-11-22 13:39:59 | 2017-12-02 00:28:42 | 2017-12-15 |
| 5 | ad21c59c0840e6cb83a9ceb5573f8159 | 8ab97904e6daea8866dbdbc4fb7aad2c | delivered | 2018-02-13 21:18:39 | 2018-02-13 22:20:29 | 2018-02-14 19:46:34 | 2018-02-16 18:17:02 | 2018-02-26 |
| 6 | a4591c265e18cb1dcee52889e2d8acc3 | 503740e9ca751ccdda7ba28e9ab8f608 | delivered | 2017-07-09 21:57:05 | 2017-07-09 22:10:13 | 2017-07-11 14:58:04 | 2017-07-26 10:57:55
