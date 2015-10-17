# For flask-socketio.
from gevent import monkey
monkey.patch_all()
from threading import Thread

from flask import Blueprint, render_template

from extensions import socketio
from models import PresidentialCandidate


thread = None
map_blueprint = Blueprint('map_blueprint', __name__,
                          template_folder="templates")


@map_blueprint.route('/')
def index():
    global thread
    if thread is None:
        thread = Thread(target=PresidentialCandidate.subscribe)
        thread.start()
    ctx = {
        'namespace': PresidentialCandidate.namespace,
        'msg_name': PresidentialCandidate.msg_name,
    }
    return render_template('index.html', **ctx)


@socketio.on('my event', namespace='/test')
def test_message(message):
    """This must be here for socketio to communicate."""
    pass
