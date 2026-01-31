# Usando inferência estatística para analisar o tempo médio de entregas de pedidos de ecommerce no Brasil

# 1. Foram considerados apenas pedidos com status delivered, uma vez que apenas nesses casos o tempo de entrega é observável. 
# Pedidos com status shipped, invoiced e unavailable foram excluídos da análise.

# Importando o dataset

library(readr)
pedidos_olist = read.csv(file = "olist_orders_dataset.csv")
pedidos_olist

# 1.1 - Filtrando apenas os pedidos com status delivered:
install.packages("dplyr")
library(dplyr)

pedidos_entregues = pedidos_olist %>%
  filter(order_status == "delivered")

# Visualizando o dataset apenas com os pedidos de status entregues
View(pedidos_entregues)
           
# 2 - Criando a variável tempo de entrega (em dias), que é a diferença entre ordem do pedido e quando o pedid
# Convertendo as datas

pedidos_entregues$order_purchase_timestamp = as.POSIXct(
  pedidos_entregues$order_purchase_timestamp,
  format = "%Y-%m-%d %H:%M:%S",
  tz = "UTC"
)

pedidos_entregues$order_delivered_customer_date = as.POSIXct(
  pedidos_entregues$order_delivered_customer_date,
  format = "%Y-%m-%d %H:%M:%S",
  tz = "UTC"
)

pedidos_entregues$tempo_entrega <- as.numeric(
  difftime(
    pedidos_entregues$order_delivered_customer_date,
    pedidos_entregues$order_purchase_timestamp,
    units = "days"
  )
)

class(pedidos_entregues$order_delivered_customer_date)

#Selecionar n = 5.000 pedidos de forma aleatória, sem viés, a partir da tabela orders.

# Fixando a semente 
set.seed(123)

n <- 5000 # tamanho da amostra 


amostra_pedidos_entregues <- pedidos_entregues[
  sample(seq_len(nrow(pedidos_entregues)), size = n, replace = FALSE),
]

# Medidas resumo da variável tempo de entrega
summary(amostra_pedidos_entregues$tempo_entrega)

# Desvio padrão e variância da variável tempo de entrega

sd(amostra_pedidos_entregues$tempo_entrega)
var(amostra_pedidos_entregues$tempo_entrega)

# Instalando e carregando as bibliotecas necessarias para plotar os gráficos

install.packages("patchwork")
library(patchwork)
install.packages("ggplot2")
library(ggplot2)

# Histograma 1

histograma_1 = ggplot(amostra_pedidos_entregues, aes(x = tempo_entrega)) +
  geom_histogram(bins = 30) +
  labs(
    tittle = "Dostribuição do Tempo de Entrega",
    x = "Tempo de Entrega (em dias)",
    y = "Frequência"
  )
  theme_minimal()

# Histograma 2
  
histograma_2 = ggplot(amostra_pedidos_entregues, aes(x = tempo_entrega)) + 
  geom_histogram(aes(y = ..density..), bins = 30) +
  geom_density() + 
  labs(
    tittle = "Dostribuição do Tempo de Entrega",
    x = "Tempo de Entrega (em dias)",
    y = "Densidade"
  )
theme_minimal()

histograma_1 | histograma_2
  
# Box Plot
  
ggplot(amostra_pedidos_entregues, aes(x = "", y = tempo_entrega)) +
  geom_boxplot() +
  coord_flip() +
  labs(
    title = "Distribuição do Tempo de Entrega",
    y = "Tempo de Entrega",
    x = ""
    ) +
  theme_minimal()


# Intervalo de confiança para a variável tempo de entrega 

x_barra = mean(amostra_pedidos_entregues$tempo_entrega)
s = sd(amostra_pedidos_entregues$tempo_entrega)
n = length(amostra_pedidos_entregues$tempo_entrega)

erro_padrao = s / sqrt(n)
t_critico = qt(0.975, df = n - 1)

IC <- c(
  x_barra - t_critico * erro_padrao,
  x_barra + t_critico * erro_padrao)

IC