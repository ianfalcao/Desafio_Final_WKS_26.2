# 🏥 Desafio Final Workshop 2026.2 - ClínicaCare
**Área de Dados | Fábrica de Software**  
**Autor:** Ian Falcão

---

## 📌 Visão Geral do Projeto
A **ClínicaCare** é uma instituição de saúde de médio porte localizada em João Pessoa que atua há 15 anos no mercado. Este projeto consiste na criação de uma solução integrada de dados para modernizar a gestão operacional e financeira da clínica, substituindo processos manuais em papel por uma arquitetura robusta de dados baseada em **Modelagem Relacional**, **Banco de Dados SQL**, **Machine Learning com Python** e **Dashboards Interativos em Power BI**.

---

## 🛠️ Estrutura do Repositório

```text
Desafio_Final_WKS_26.2/
├── 1_Modelagem/
│   ├── Modelo_Conceitual_ER.pdf
│   └── Modelo_Logico.txt
├── 2_SQL/
│   ├── clinica_care.sql
│   └── Analise_Consultas.docx
├── 3_Python/
│   ├── analise_clinica.ipynb
│   └── dados_limpos.csv
├── 4_Power_BI/
│   ├── Dashboard_ClinicaCare.pbix
│   ├── dados.csv
│   └── Insights_Dashboard.docx
└── README.md
```

---

## 🚀 Resumo dos Módulos Desenvolvidos

### 📂 1. Modelagem de Dados
- **Modelo Conceitual (E-R):** Mapeamento do domínio da clínica cobrindo 8 entidades principais (*Pacientes, Médicos, Especialidades, Consultas, Prontuários, Pagamentos, Planos de Saúde e Disponibilidade*).
- **Modelo Lógico Normalizado:** Implementação de integridade referencial (PKs, FKs, restrições `NOT NULL` e `UNIQUE`), normalização na 3FN e resolução do relacionamento N:M entre Médicos e Especialidades através de tabela associativa.

### 💻 2. Banco de Dados SQL (`clinica_care.sql`)
- **DDL (Data Definition Language):** Criação do schema `clinica_care` e de todas as tabelas normalizadas.
- **DML (Data Manipulation Language):** Povoamento de dados consistentes e realistas, além de rotinas de `UPDATE` para atualização de status de consultas e recebimento de pagamentos.
- **DQL (Data Query Language):** Desenvolvimento de consultas analíticas avançadas utilizando agregação (`SUM`, `AVG`, `COUNT`) e joins (`INNER JOIN`, `LEFT JOIN`) para análise de faturamento por médico, especialidade e convênio.

### 🐍 3. Python + Machine Learning (Tema 2: Risco de Inadimplência)
- **Análise Exploratória & Tratamento:** Limpeza de nulos, exportação do dataset `dados_limpos.csv` e análise estatística via **NumPy** do tempo médio e desvio padrão de atraso no pagamento.
- **Visualizações (Matplotlib/Seaborn):** Gráfico do percentual de atraso por plano de saúde e gráfico de pizza com a distribuição dos status de pagamento.
- **Algoritmo Preditivo:** Treinamento de um pipeline de Machine Learning (**Random Forest Classifier**) para classificação do risco de inadimplência em 3 níveis (*Baixo*, *Médio* e *Alto*), identificando as principais variáveis determinantes na inadimplência.

### 📊 4. Power BI
- **Modelagem Star Schema:** Relacionamento entre tabelas fato de consultas e pagamentos com dimensões do paciente, médico e calendário.
- **Dashboard Executivo:**
  - *KPIs:* Total de Pacientes, Receita Total e Taxa de Ocupação.
  - *Visualizações:* Consultas por Especialidade (Barras), Faturamento Mensal (Colunas), Distribuição por Plano (Pizza) e Evolução da Taxa de No-Shows (Linhas).
  - *Filtros & Navegação:* Slicers por período, médico e tipo de plano de saúde.

---

## ⚙️ Como Executar os Arquivos

1. **SQL:** Execute o script `2_SQL/clinica_care.sql` no **MySQL Workbench** ou SGBD MySQL de sua preferência.
2. **Python / ML:** Abra o notebook `3_Python/analise_clinica.ipynb` no **Google Colab** ou **Jupyter Notebook**, garantindo que o arquivo `dataset_inadimplencia_clinica.csv` esteja no mesmo diretório.
3. **Power BI:** Abra o arquivo `4_Power_BI/Dashboard_ClinicaCare.pbix` através do **Power BI Desktop**.

---
*Projeto desenvolvido para o Desafio Final do Workshop de Dados 2026.2 - Fábrica de Software.*
