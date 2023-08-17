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

@app.route('/inserir_aluno', methods=['GET','POST'])
def inserir_aluno():

    if request.method == 'POST':
        nome = request.form['nome']
        cpf = request.form['cpf']
        datanascimento = request.form['datanascimento']
        endereco = request.form['endereco']
        telefone = request.form['telefone']
        numeromatricula = request.form['numeromatricula']
        datamatricula = request.form['datamatricula']
        alunoespecial = request.form['especial']

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Inserir dados na base de dados
        insert_pessoa_query = "INSERT INTO pessoa (nome, cpf, datanascimento, endereco, telefone) VALUES (%s, %s, %s, %s, %s)"
        pessoa_values = (nome, cpf, datanascimento, endereco, telefone)
        cursor.execute(insert_pessoa_query, pessoa_values)

        # Obter o id da pessoa gerada na inserção anterior
        pessoa_id = cursor.lastrowid

        #Inserir na tabela aluno com a FK referenciando a pessoa
        insert_aluno_query = "INSERT INTO aluno (codigopessoa, numeromatricula, datamatricula, alunoespecial) VALUES (%s, %s, %s, %s)"
        aluno_values = (pessoa_id, numeromatricula, datamatricula, alunoespecial)
        cursor.execute(insert_aluno_query, aluno_values)

        conn.commit()

        return render_template('inserir_aluno.html')


    return render_template('inserir_aluno.html')

if __name__ == '__main__':
    app.run(debug=True)

