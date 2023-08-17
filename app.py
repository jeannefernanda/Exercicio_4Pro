from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
db_config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'database': 'escola',
    'ssl_disabled': True
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/listar_alunos')
def listar_alunos():
    conn  = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Selecionar atributos dos alunos
    cursor.execute("SELECT nome, cpf, datanascimento, endereco, telefone, numeromatricula, datamatricula, alunoespecial FROM aluno JOIN pessoa ON aluno.codigopessoa = pessoa.codigo")
    alunos = cursor.fetchall()

    #print(alunos)

    cursor.close()
    conn.close()
 
    return render_template('listar_alunos.html', alunos=alunos)

if __name__ == '__main__':
    app.run(debug=True)