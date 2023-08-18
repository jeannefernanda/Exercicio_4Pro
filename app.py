from datetime import datetime
from flask import Flask, redirect, render_template, request, url_for
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
    cursor.execute("SELECT nome, cpf, DATE_FORMAT(datanascimento, '%d/%m/%Y'), endereco, telefone, numeromatricula, DATE_FORMAT(datamatricula, '%d/%m/%Y'), alunoespecial, codigopessoa FROM aluno JOIN pessoa ON aluno.codigopessoa = pessoa.codigo")
    alunos = cursor.fetchall()

    print(alunos)

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

        # Convertendo a data para o formato yyyy/mm/dd
        datanascimento_converted = datetime.strptime(datanascimento, '%d/%m/%Y').strftime('%Y/%m/%d')
        datamatricula_converted = datetime.strptime(datamatricula, '%d/%m/%Y').strftime('%Y/%m/%d')


        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Inserir dados na base de dados
        insert_pessoa_query = "INSERT INTO pessoa (nome, cpf, datanascimento, endereco, telefone) VALUES (%s, %s, %s, %s, %s)"
        pessoa_values = (nome, cpf, datanascimento_converted, endereco, telefone)
        cursor.execute(insert_pessoa_query, pessoa_values)

        # Obter o id da pessoa gerada na inserção anterior
        pessoa_id = cursor.lastrowid

        #Inserir na tabela aluno com a FK referenciando a pessoa
        insert_aluno_query = "INSERT INTO aluno (codigopessoa, numeromatricula, datamatricula, alunoespecial) VALUES (%s, %s, %s, %s)"
        aluno_values = (pessoa_id, numeromatricula, datamatricula_converted, alunoespecial)
        cursor.execute(insert_aluno_query, aluno_values)

        conn.commit()

        return render_template('inserir_aluno.html')


    return render_template('inserir_aluno.html')

@app.route('/relatorio', methods=['GET','POST'])
def relatorio():
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM curso")
    cursos = cursor.fetchall()

    if request.method == 'POST':
        cursor.execute("SELECT * FROM curso")
        cursor.fetchall()

        # Selecionar alunos por curso
        id_curso = request.form['curso_id']
        cursor.execute("SELECT * FROM aluno JOIN pessoa ON aluno.codigopessoa = pessoa.codigo JOIN matricula ON aluno.codigo = matricula.codigoaluno  JOIN turma ON matricula.codigoturma = turma.codigo JOIN curso ON turma.codigocurso = curso.codigo WHERE curso.codigo = %s", (id_curso,))
        alunos = cursor.fetchall()

        print(alunos)

        return render_template('relatorio.html', alunos=alunos, cursos=cursos)

    return render_template('relatorio.html', cursos=cursos)

@app.route('/editar_aluno/<int:codigo>', methods=['GET', 'POST'])
def editar_aluno(codigo):
    if request.method == 'POST':
        # Obter os dados do formulário
        nome = request.form['nome']
        cpf = request.form['cpf']
        datanascimento = request.form['datanascimento']
        endereco = request.form['endereco']
        telefone = request.form['telefone']
        numeromatricula = request.form['numeromatricula']
        datamatricula = request.form['datamatricula']
        alunoespecial = request.form['especial']

        # Convertendo datas para o formato do banco de dados
        datanascimento_converted = datetime.strptime(datanascimento, '%d/%m/%Y').strftime('%Y/%m/%d')
        datamatricula_converted = datetime.strptime(datamatricula, '%d/%m/%Y').strftime('%Y/%m/%d')

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        # Atualizar dados na tabela pessoa
        update_pessoa_query = "UPDATE pessoa SET nome = %s, cpf = %s, datanascimento = %s, endereco = %s, telefone = %s WHERE codigo = %s"
        pessoa_values = (nome, cpf, datanascimento_converted, endereco, telefone, codigo)
        cursor.execute(update_pessoa_query, pessoa_values)

        # Atualizar dados na tabela aluno
        update_aluno_query = "UPDATE aluno SET numeromatricula = %s, datamatricula = %s, alunoespecial = %s WHERE codigopessoa = %s"
        aluno_values = (numeromatricula, datamatricula_converted, alunoespecial, codigo)
        cursor.execute(update_aluno_query, aluno_values)

        conn.commit()
        conn.close()

        return redirect(url_for('listar_alunos'))  # Redirecionar para a lista de alunos após a edição
    else:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Obter dados do aluno a ser editado
        select_aluno_query = "SELECT p.codigo, p.nome, p.cpf, DATE_FORMAT(p.datanascimento, '%d/%m/%Y'), p.endereco, p.telefone, a.numeromatricula, DATE_FORMAT(a.datamatricula, '%d/%m/%Y'), a.alunoespecial FROM pessoa p JOIN aluno a ON p.codigo = a.codigopessoa WHERE a.codigopessoa = %s"
        cursor.execute(select_aluno_query, (codigo,))
        aluno_data = cursor.fetchone()

        conn.close()

        if aluno_data:
            return render_template('editar_aluno.html', aluno=aluno_data)
        else:
            # Aluno não encontrado, lidar com esse caso
            return "Aluno não encontrado"

if __name__ == '__main__':
    app.run(debug=True)

