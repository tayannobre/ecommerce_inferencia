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

#### Importante ressaltar que foi usado na análise apenas os pedidos com status deliverid, uma vez que apenas nesses casos o tempo de entrega pode ser pobservado. Pedidos com status shipped, invoiced, unavailable etc foram excluídos da observação.

``` 
# 1.1 - Filtrando apenas os pedidos com status delivered:

pedidos_entregues = olist_orders_dataset %>%
  filter(order_status == "delivered")

```
