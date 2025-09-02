FROM python:3.9-slim

# Criar pasta de trabalho e instalar dependências
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar os conteúdos da aplicação
COPY service/ ./service/

# Mudar para um usuário não-root
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Executar o serviço
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
