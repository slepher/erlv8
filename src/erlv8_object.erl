-module(erlv8_object,[Resource,VM]).
-export([proplist/0, set_value/2, set_hidden_value/2, get_value/1, get_value/2, get_hidden_value/1, get_hidden_value/2, set_prototype/1, get_prototype/0, equals/1, strict_equals/1, call/1, call/2,new/1]).

proplist() ->
	erlv8_nif:to_proplist(Resource).

set_value(Key,Value) ->
	erlv8_nif:object_set(Resource, Key, Value).

set_hidden_value(Key,Value) ->
	erlv8_nif:object_set_hidden(Resource, Key, Value).

get_value(Key) ->
	get_value(Key, undefined).

get_value(Key, Default) ->
	case erlv8_nif:object_get(Resource, Key) of
		undefined ->
			Default;
		Val ->
			Val
	end.

get_hidden_value(Key) ->
	get_hidden_value(Key, undefined).

get_hidden_value(Key, Default) ->
	case erlv8_nif:object_get_hidden(Resource, Key) of
		undefined ->
			Default;
		Val ->
			Val
	end.

set_prototype(Proto) ->
	erlv8_nif:object_set_proto(Resource, Proto).

get_prototype() ->
	erlv8_nif:object_get_proto(Resource).

equals({_Tag,AnotherObject,_}) ->
	erlv8_value:equals(Resource, AnotherObject).

strict_equals({_Tag,AnotherObject,_}) ->
	erlv8_value:strict_equals(Resource, AnotherObject).

call(Fun) ->
	call(Fun,[]).

call(Fun,Args) ->
    Fun:call({erlv8_object, Resource,VM}, Args).
	
new(O) ->
	instance(O,undefined).
	
