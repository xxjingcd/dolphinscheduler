# -*- coding: utf-8 -*-

"""
@Time    : 2021/1/8 19:32
@Author  : xuxiaojing
@desc    : 企业微信发送的工具类
"""
import sys
import requests


def send_msg_txt(send_url, content):
    headers = {"Content-Type": "text/plain"}
    send_data = {
        "msgtype": "markdown",  # 消息类型，此时固定为text
        "markdown": {
            "content": content,  # 文本内容，最长不超过2048个字节，必须是utf8编码
            "mentioned_list": ["@all"],
            # userid的列表，提醒群中的指定成员(@某个成员)，@all表示提醒所有人，如果开发者获取不到userid，可以使用mentioned_mobile_list
            "mentioned_mobile_list": ["@all"]  # 手机号列表，提醒手机号对应的群成员(@某个成员)，@all表示提醒所有人
        }
    }
    res = requests.post(url=send_url, headers=headers, json=send_data, verify=False)
    print(res.text)


if __name__ == '__main__':
    project_name = sys.argv[1]
    branch_name = sys.argv[2]
    build_url = sys.argv[3]
    deploy_env = sys.argv[4]
    report_url = None

    if len(sys.argv) == 6:
        msg_type = sys.argv[5]
    elif len(sys.argv) == 7:
        report_url = sys.argv[5]
        msg_type = sys.argv[6]
    base_url = 'http://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=5aca06e2-90c5-47c0-80ca-7f591ad750c8'
    if msg_type == 'build_start':
        content = "**自动化测试消息**：\n>将开始<font color=\"info\">%s 构建</font>，请相关同事注意。\n>分支名称: <font color=\"comment\">%s</font>\n>构建环境: <font color=\"comment\">%s</font>\n>构建进度请查看: <font color=\"comment\">%s</font>" % (
            project_name,
            branch_name,
            deploy_env,
            build_url)
    elif msg_type == 'build_stop':
        content = "**自动化测试消息**：\n><font color=\"warning\">%s构建**成功**</font>，请相关同事注意。\n>分支名称: <font color=\"comment\">%s</font>\n>构建环境: <font color=\"comment\">%s</font>\n>构建结果请查看: <font color=\"comment\">%s </font>" % (
            project_name,
            branch_name,
            deploy_env,
            build_url)
    elif msg_type == 'build_fail':
        content = "**自动化测试消息**：\n><font color=\"warning\">%s构建**失败**</font>，请相关同事及时处理。\n>分支名称: <font color=\"comment\">%s</font>\n>构建环境: <font color=\"comment\">%s</font>\n>构建结果请查看: <font color=\"comment\"> %s </font>" % (
            project_name,
            branch_name,
            deploy_env,
            build_url)
    if report_url:
        content += "\n>接口测试报告请查看: <font color=\"comment\"> %s </font>" % report_url
    send_msg_txt(base_url, content)
