"""
@Description :   beginning and entrance
@Author      :   chenyu 
@Time        :   2021/10/29 23:34:34
"""

from flask import Flask, render_template
from config import flask_config

app = Flask(__name__, static_url_path='/' ,static_folder='static', template_folder='templates') # 实例化Flask
app.config.from_object(flask_config) # 载入配置文件

@app.route('/') # 创建根路由
def hello_world():
    return render_template('index.html')

# 启动
if __name__ == '__main__':
    app.run()