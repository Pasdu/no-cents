extends Node

signal server_started
signal server_stopped

signal add_client(client)
signal remove_client(client)

signal add_admin(id)

signal output(scope, text)

var manifest

var players_connected = []
var admins_connected = []

var clients_by_id = {}
var players_by_nickname = {}

var websocket

func _ready():
	pass

func _process(delta):

	if websocket != null and websocket.is_listening(): # is_listening is true when the server is active and listening
		websocket.poll();	


func start_websocket_server(port):
	websocket = WebSocketServer.new();
	
	var _error = get_tree().connect("network_peer_connected", self, "_player_connected")
	_error = get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	websocket.listen(port, PoolStringArray(), true);
	
	get_tree().set_network_peer(websocket);
	emit_signal("server_started")
	emit_signal("output", "global", "[b]Server Started on port " + String(port) + "[/b] \n Server is Listening: " + String(websocket.is_listening()))
	if not websocket.is_listening():
		stop_server()

func stop_server():
	get_tree().network_peer.stop()
	emit_signal("server_stopped")
	emit_signal("output", "global", "[b]Server Stopped.[/b]")
	

