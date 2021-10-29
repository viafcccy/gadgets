"""
@Description :   beginning and entrance
@Author      :   chenyu 
@Time        :   2021/10/29 23:34:34
"""

from flask import Flask
from config import flask_config

app = Flask(__name__) # 实例化Flask
# 载入配置文件
app.config.from_object(flask_config)

@app.route('/') # 创建根路由
def hello_world():
    return 'hello world!'

# 启动
if __name__ == '__main__':
    app.run()