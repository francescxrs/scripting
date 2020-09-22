import psycopg2
conn = psycopg2.connect(dbname="proyecto_03_db", user="proyecto_03_user", password="proyecto_03_user")
print("Connexió a base de dades correcta")
