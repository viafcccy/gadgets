"""
@Description :   beginning and entrance
@Author      :   chenyu 
@Time        :   2021/10/29 23:34:34
"""

import os
from flask import Flask, render_template
from gadgets_site.config import flask_config # 由../run.py import gadges_site包 自动运行__init__.py，此时路径还是留在../run.py目录下

app = Flask(__name__, static_url_path='/' ,static_folder='static', template_folder='templates') # 实例化Flask
app.config.from_mapping(flask_config.flask_config_dic) # 载入配置文件
app.config['SERCRET_KRY'] = os.urandom(24) # 生成随机数种子用于SessionID

@app.route('/') # 创建根路由
def hello_world():
    return render_template('index.html')

@app.route('/article')
def article():
    return render_template('article.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/post')
def post():
    return render_template('post.html')

# 自定义404错误页面
@app.errorhandler(404)
def page_not_find(err):
    return render_template('error-404.html')

# 自定义500错误页面
@app.errorhandler(500)
def server_inside_err(err):
    return render_template('error-500.html')

# 启动
if __name__ == '__main__':
    app.run()